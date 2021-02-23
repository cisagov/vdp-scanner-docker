# vdp-scanner-docker 🔍📄 #

[![GitHub Build Status](https://github.com/cisagov/vdp-scanner-docker/workflows/build/badge.svg)](https://github.com/cisagov/vdp-scanner-docker/actions)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/cisagov/vdp-scanner-docker.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/cisagov/vdp-scanner-docker/alerts/)
[![Language grade: Python](https://img.shields.io/lgtm/grade/python/g/cisagov/vdp-scanner-docker.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/cisagov/vdp-scanner-docker/context:python)

## Docker Image ##

[![Docker Pulls](https://img.shields.io/docker/pulls/cisagov/vdp-scanner-docker)](https://hub.docker.com/r/cisagov/vdp-scanner)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/cisagov/vdp-scanner)](https://hub.docker.com/r/cisagov/vdp-scanner)
[![Platforms](https://img.shields.io/badge/platforms-amd64%20%7C%20arm%2Fv6%20%7C%20arm%2Fv7%20%7C%20arm64%20%7C%20ppc64le%20%7C%20s390x-blue)](https://hub.docker.com/r/cisagov/vdp-scanner/tags)

This is a Docker project to scan either the
[GSA current Federal .gov domain list](https://github.com/GSA/data/blob/master/dotgov-domains/current-federal.csv)
, or a given CSV in the same format, with the
[cisagov/hash-http-content](https://github.com/cisagov/hash-http-content)
Python library. Then it will output CSVs with Agency and domain level results.

## Usage ##

### Install ###

Pull `cisagov/vdp-scanner` from the Docker repository:

```console
docker pull cisagov/vdp-scanner
```

Or build `cisagov/vdp-scanner` from source:

```console
git clone https://github.com/cisagov/vdp-scanner-docker.git
cd vdp-scanner-docker
docker-compose build
```

### Run ###

This Docker image needs a bind mount to get the output from the script to the
host.

Using `docker run`

```console
docker run --mount type=bind,source=$(pwd),target=/task/host_mount --rm cisagov/vdp-scanner
```

or if you have cloned the repository, you can use the included
`docker-compose.yml`

```console
docker-compose up
```

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
