FROM python:3.10.10-alpine3.17 AS compile-stage

# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
# Note: Additional labels are added by the build workflow.
LABEL org.opencontainers.image.authors="nicholas.mcdonnell@cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

RUN apk --no-cache add \
  libxml2-dev=2.10.3-r1 \
  libxslt-dev=1.1.37-r0

ENV VIRTUAL_ENV=/task/.venv

# Install pipenv to manage installing the Python dependencies into a created
# Python virtual environment. This is done separately from the virtual
# environment so that pipenv and its dependencies are not installed in the
# Python virtual environment used in the final image.
RUN python -m pip install --no-cache-dir --upgrade pipenv==2022.9.8 \
  # Manually create Python virtual environment for the final image
  && python3 -m venv ${VIRTUAL_ENV} \
  # Ensure the core Python packages are installed in the virtual environment
  && ${VIRTUAL_ENV}/bin/python3 -m pip install --no-cache-dir --upgrade \
    pip==22.2.2 \
    setuptools==65.3.0 \
    wheel==0.37.1

# Install vdp_scanner.py requirements
WORKDIR /tmp
COPY src/Pipfile src/Pipfile.lock ./
# pipenv will install packages into the virtual environment specified in the
# VIRTUAL_ENV environment variable if it is set.
RUN pipenv sync --clear --verbose

FROM python:3.10.10-alpine3.17 AS build-stage

RUN apk --no-cache add \
  ca-certificates=20220614-r4 \
  chromium=110.0.5481.177-r0 \
  libxml2-dev=2.10.3-r1 \
  libxslt-dev=1.1.37-r0

ENV VIRTUAL_ENV=/task/.venv
COPY --from=compile-stage ${VIRTUAL_ENV} ${VIRTUAL_ENV}/
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

ENV TASK_HOME="/task"

WORKDIR ${TASK_HOME}
RUN mkdir host_mount

COPY src/version.txt src/vdp_scanner.py ./

ENTRYPOINT ["python", "vdp_scanner.py"]
CMD ["github"]
