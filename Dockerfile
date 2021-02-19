FROM python:3.9-alpine

# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
# Note: Additional labels are added by the build workflow.
LABEL org.opencontainers.image.authors="nicholas.mcdonnell@cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cyber and Infrastructure Security Agency"

ARG CISA_UID=421
ENV CISA_HOME="/home/cisa"
ENV ECHO_MESSAGE="Hello World from Dockerfile"

RUN addgroup --system --gid ${CISA_UID} cisa \
  && adduser --system --uid ${CISA_UID} --ingroup cisa cisa

RUN apk --update --no-cache add \
ca-certificates \
openssl \
py-pip

WORKDIR ${CISA_HOME}

USER cisa

ENTRYPOINT ["python", "vdp-scanner.py"]
