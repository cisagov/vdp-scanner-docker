# vdp-scanner-docker 💀🐳 #

[![GitHub Build Status](https://github.com/cisagov/vdp-scanner-docker/workflows/build/badge.svg)](https://github.com/cisagov/vdp-scanner-docker/actions)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/cisagov/vdp-scanner-docker.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/cisagov/vdp-scanner-docker/alerts/)
[![Language grade: Python](https://img.shields.io/lgtm/grade/python/g/cisagov/vdp-scanner-docker.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/cisagov/vdp-scanner-docker/context:python)

## Docker Image ##

[![Docker Pulls](https://img.shields.io/docker/pulls/cisagov/vdp-scanner-docker)](https://hub.docker.com/r/cisagov/vdp-scanner)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/cisagov/vdp-scanner)](https://hub.docker.com/r/cisagov/vdp-scanner)
[![Platforms](https://img.shields.io/badge/platforms-amd64%20%7C%20arm%2Fv6%20%7C%20arm%2Fv7%20%7C%20arm64%20%7C%20ppc64le%20%7C%20s390x-blue)](https://hub.docker.com/r/cisagov/vdp-scanner/tags)

This is a docker skeleton project that can be used to quickly get a
new [cisagov](https://github.com/cisagov) GitHub docker project
started.  This skeleton project contains [licensing
information](LICENSE), as well as [pre-commit hooks](https://pre-commit.com)
and [GitHub Actions](https://github.com/features/actions) configurations
appropriate for docker containers and the major languages that we use.

## Usage ##

### Install ###

Pull `cisagov/vdp-scanner` from the Docker repository:

    docker pull cisagov/vdp-scanner

Or build `cisagov/vdp-scanner` from source:

    git clone https://github.com/cisagov/vdp-scanner-docker.git
    cd vdp-scanner-docker
    docker-compose build --build-arg VERSION=0.0.1

### Run ###

    docker-compose run --rm vdp-scanner

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
