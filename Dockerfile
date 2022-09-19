FROM python:3.10.7-bullseye AS compile-stage

# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
# Note: Additional labels are added by the build workflow.
LABEL org.opencontainers.image.authors="nicholas.mcdonnell@cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

RUN apt-get update \
  && apt-get install -y --allow-downgrades --no-install-recommends \
    libxml2-dev=2.9.10+dfsg-6.7+deb11u2 \
    libxslt1-dev=1.1.34-4+deb11u1

ENV PY_VENV=/.venv

# Manually set up the virtual environment
RUN python -m venv --system-site-packages ${PY_VENV}
ENV PATH="${PY_VENV}/bin:$PATH"

# Install core Python dependencies
RUN python -m pip install --no-cache-dir \
  pip==22.1.2 \
  pipenv==2022.6.7 \
  setuptools==62.4.0 \
  wheel==0.37.1

# Install vdp_scanner.py requirements
COPY src/Pipfile Pipfile
COPY src/Pipfile.lock Pipfile.lock
# PIPENV_VENV_IN_PROJECT=1 directs pipenv to use the current directory for venvs
RUN PIPENV_VENV_IN_PROJECT=1 pipenv sync

# We only need pipenv to set up the environment, so we remove it from the venv
# as a last step.
RUN python -m pip uninstall --yes pipenv

FROM python:3.10.7-slim-bullseye AS build-stage

RUN apt-get update \
  && apt-get install -y --allow-downgrades --no-install-recommends \
    ca-certificates=20210119 \
    chromium=104.0.5112.79-1~deb11u1 \
    chromium-common=104.0.5112.79-1~deb11u1 \
    libxml2-dev=2.9.10+dfsg-6.7+deb11u2 \
    libxslt1-dev=1.1.34-4+deb11u1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV PY_VENV=/.venv
COPY --from=compile-stage ${PY_VENV} ${PY_VENV}
ENV PATH="${PY_VENV}/bin:$PATH"

ENV TASK_HOME="/task"

WORKDIR ${TASK_HOME}
RUN mkdir host_mount

COPY src/version.txt version.txt
COPY src/vdp_scanner.py vdp_scanner.py

ENTRYPOINT ["python", "vdp_scanner.py"]
CMD ["github"]
