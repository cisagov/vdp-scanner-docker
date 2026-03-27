<<<<<<< HEAD
# We use an Alpine base image in the compile-stage because of the build
# requirements for some of the Python requirements. When the python3-dev
# package is installed it will also install the python3 package which leaves us
# with two Python installations if we use a Python Docker image. Instead we use
# Alpine's python3 package here to create the virtual environment we will use
# in the Python Docker image we use for the build-stage. The tag of the Python
# Docker image matches the version of the python3 package available on Alpine
# for consistency.
FROM docker.io/library/alpine:3.22 AS compile-stage
=======
# Official Docker images are in the form library/<app> while non-official
# images are in the form <user>/<app>.
<<<<<<< HEAD
<<<<<<< HEAD
FROM docker.io/library/python:3.13.7-alpine3.22 AS compile-stage
>>>>>>> 7da4b0d561c4888571dd9bf161dcadfc42110edf
=======
FROM docker.io/library/python:3.14.2-alpine3.22 AS compile-stage
>>>>>>> 18f4516ccbf2bed919ab3ad206443bed01103ee5
=======
FROM docker.io/library/python:3.14.3-alpine3.23 AS compile-stage
>>>>>>> cdd0eb7c54a6982e1cac5e92cb7f61d7d74c97e0

###
# Unprivileged user variables
###
ARG CISA_USER="cisa"
ENV CISA_HOME="/home/${CISA_USER}"
ENV VIRTUAL_ENV="${CISA_HOME}/.venv"

# Versions of the Python packages installed directly
ENV PYTHON_PIP_VERSION=26.0.1
ENV PYTHON_PIPENV_VERSION=2026.0.3
ENV PYTHON_SETUPTOOLS_VERSION=82.0.0

RUN apk --no-cache add \
  py3-lxml=5.3.1-r3 \
  py3-pip=25.1.1-r0 \
  py3-setuptools=80.9.0-r0 \
  py3-wheel=0.46.1-r0 \
  python3-dev=3.12.11-r0 \
  python3=3.12.11-r0

###
<<<<<<< HEAD
# Create a Python virtual environment (venv) for setup (due to PEP 668); install the
# specified versions of pip, setuptools, and wheel into the setup venv; install the
# specified version of pipenv into the setup venv; create the image dependency venv;
# and install the specified versions of pip, setuptools, and wheel into the dependency
# venv.
=======
# Install the specified versions of pip and setuptools into the system
# Python environment; install the specified version of pipenv into the system Python
# environment; set up a Python virtual environment (venv); and install the specified
# versions of pip and setuptools into the venv.
>>>>>>> cdd0eb7c54a6982e1cac5e92cb7f61d7d74c97e0
#
# Note that we use the --no-cache-dir flag to avoid writing to a local
# cache.  This results in a smaller final image, at the cost of
# slightly longer install times.
###
RUN python3 -m venv --system-site-packages /usr/local \
    # Ensure the core Python packages are installed in the virtual environment
    && /usr/local/bin/python3 -m pip install --no-cache-dir --upgrade \
        pip==${PYTHON_PIP_VERSION} \
        setuptools==${PYTHON_SETUPTOOLS_VERSION} \
<<<<<<< HEAD
        wheel==${PYTHON_WHEEL_VERSION} \
    && /usr/local/bin/python3 -m pip install --no-cache-dir --upgrade \
=======
    && python3 -m pip install --no-cache-dir --upgrade \
>>>>>>> cdd0eb7c54a6982e1cac5e92cb7f61d7d74c97e0
        pipenv==${PYTHON_PIPENV_VERSION} \
    # Manually create the virtual environment
    && python3 -m venv --system-site-packages ${VIRTUAL_ENV} \
    # Ensure the core Python packages are installed in the virtual environment
    && ${VIRTUAL_ENV}/bin/python3 -m pip install --no-cache-dir --upgrade \
        pip==${PYTHON_PIP_VERSION} \
        setuptools==${PYTHON_SETUPTOOLS_VERSION}

###
# Check the Pipfile configuration and then install the Python dependencies into
# the virtual environment.
#
# Note that pipenv will install into a virtual environment if the VIRTUAL_ENV
# environment variable is set.
###
WORKDIR /tmp
COPY src/Pipfile src/Pipfile.lock ./
RUN pipenv install --clear --deploy --extra-pip-args "--no-cache-dir" --verbose

<<<<<<< HEAD
# The version of Python used here should match the version of the Alpine
# python3 package installed in the compile-stage.
FROM docker.io/library/python:3.12.11-alpine3.22 AS build-stage
=======
# Official Docker images are in the form library/<app> while non-official
# images are in the form <user>/<app>.
<<<<<<< HEAD
<<<<<<< HEAD
FROM docker.io/library/python:3.13.7-alpine3.22 AS build-stage
>>>>>>> 7da4b0d561c4888571dd9bf161dcadfc42110edf
=======
FROM docker.io/library/python:3.14.2-alpine3.22 AS build-stage
>>>>>>> 18f4516ccbf2bed919ab3ad206443bed01103ee5
=======
FROM docker.io/library/python:3.14.3-alpine3.23 AS build-stage
>>>>>>> cdd0eb7c54a6982e1cac5e92cb7f61d7d74c97e0

###
# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
#
# Note: Additional labels are added by the build workflow.
###
<<<<<<< HEAD
LABEL org.opencontainers.image.authors="vm-fusion-dev-group@trio.dhs.gov"
=======
# github@cisa.dhs.gov is a very generic email distribution, and it is
# unlikely that anyone on that distribution is familiar with the
# particulars of your repository.  It is therefore *strongly*
# suggested that you use an email address here that is specific to the
# person or group that maintains this repository; for example:
# LABEL org.opencontainers.image.authors="vm-dev@gwe.cisa.dhs.gov"
LABEL org.opencontainers.image.authors="github@cisa.dhs.gov"
>>>>>>> 18f4516ccbf2bed919ab3ad206443bed01103ee5
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

###
# Unprivileged user setup variables
###
ARG CISA_UID=2048
ARG CISA_GID=${CISA_UID}
ARG CISA_USER="cisa"
ENV CISA_GROUP=${CISA_USER}
ENV CISA_HOME="/home/${CISA_USER}"
ENV VIRTUAL_ENV="${CISA_HOME}/.venv"

RUN apk --no-cache add \
  ca-certificates=20241121-r2 \
  chromium=138.0.7204.93-r0 \
  py3-lxml=5.3.1-r3

# Create unprivileged user
RUN addgroup --system --gid ${CISA_GID} ${CISA_GROUP} \
  && adduser --system --uid ${CISA_UID} --ingroup ${CISA_GROUP} ${CISA_USER}

###
# Copy in the Python virtual environment created in compile-stage, symlink the
# Python binary in the venv to the system-wide Python, and add the venv to the PATH.
#
# Note that we symlink the Python binary in the venv to the system-wide Python so that
# any calls to `python3` will use our virtual environment. We are using short flags
# because the ln binary in Alpine Linux does not support long flags. The -f instructs
# ln to remove the existing file and the -s instructs ln to create a symbolic link.
###
COPY --from=compile-stage --chown=${CISA_USER}:${CISA_GROUP} ${VIRTUAL_ENV} ${VIRTUAL_ENV}
RUN ln -fs "$(command -v python3)" "${VIRTUAL_ENV}"/bin/python3
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

WORKDIR ${CISA_HOME}
RUN mkdir host_mount

# Copy in the necessary files
COPY --chown=${CISA_USER}:${CISA_GROUP} src/version.txt src/vdp_scanner.py ./

###
# Prepare to run
###
USER ${CISA_USER}:${CISA_GROUP}
<<<<<<< HEAD
ENTRYPOINT ["python3", "vdp_scanner.py"]
CMD ["github"]
=======
EXPOSE 8080/tcp
VOLUME ["/var/log"]
ENTRYPOINT ["example"]
CMD ["--log-level", "DEBUG", "8", "2"]
>>>>>>> 2186042ec0ad445b8f25e7ca44108450f84b49f6
