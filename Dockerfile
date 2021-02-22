ARG PY_VERSION=3.9

FROM python:${PY_VERSION}-slim AS compile-stage

# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
# Note: Additional labels are added by the build workflow.
LABEL org.opencontainers.image.authors="nicholas.mcdonnell@cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cyber and Infrastructure Security Agency"

ENV PY_VENV=/.venv

# Manually set up the virtual environment
RUN python -m venv --system-site-packages ${PY_VENV}
ENV PATH="${PY_VENV}/bin:$PATH"

# Install core Python dependencies
RUN python -m pip install --no-cache-dir \
  pip==21.0.1 \
  pipenv==2020.11.15 \
  setuptools==53.0.0 \
  wheel==0.36.2

# Install vdp_scanner.py requirements
COPY src/Pipfile Pipfile
COPY src/Pipfile.lock Pipfile.lock
# PIPENV_VENV_IN_PROJECT=1 directs pipenv to use the current directory for venvs
RUN PIPENV_VENV_IN_PROJECT=1 pipenv sync

RUN python -m pip uninstall --yes pipenv

FROM python:${PY_VERSION}-slim AS build-stage

ARG SERVERLESS_CHROME_VERSION="v1.0.0-57"
ARG SERVERLESS_CHROME_LOCAL="/usr/local/bin/serverless-chrome"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates=20200601~deb10u2 \
    chromium-common=88.0.4324.182-1~deb10u1 \
    curl=7.64.0-4+deb10u1 \
    libnss3=2:3.42.1-1+deb10u3 \
    openssl=1.1.1d-0+deb10u4 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Download the specified serverless chrome release and install it for use
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# Follow redirects and output as the specified file name
RUN curl -L \
  https://github.com/adieuadieu/serverless-chrome/releases/download/${SERVERLESS_CHROME_VERSION}/stable-headless-chromium-amazonlinux-2.zip \
  | gunzip --stdout - > ${SERVERLESS_CHROME_LOCAL}
RUN chmod 755 ${SERVERLESS_CHROME_LOCAL}

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
