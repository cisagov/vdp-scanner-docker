# vdp-scanner-docker 🔍📄 #

<<<<<<< HEAD
[![GitHub Build Status](https://github.com/cisagov/vdp-scanner-docker/workflows/build/badge.svg)](https://github.com/cisagov/vdp-scanner-docker/actions/workflows/build.yml)
[![CodeQL](https://github.com/cisagov/vdp-scanner-docker/workflows/CodeQL/badge.svg)](https://github.com/cisagov/vdp-scanner-docker/actions/workflows/codeql-analysis.yml)
=======
[![GitHub Build Status](https://github.com/cisagov/skeleton-docker/workflows/build/badge.svg)](https://github.com/cisagov/skeleton-docker/actions/workflows/build.yml)
[![License](https://img.shields.io/github/license/cisagov/skeleton-docker)](https://spdx.org/licenses/)
[![CodeQL](https://github.com/cisagov/skeleton-docker/workflows/CodeQL/badge.svg)](https://github.com/cisagov/skeleton-docker/actions/workflows/codeql-analysis.yml)
>>>>>>> 18f4516ccbf2bed919ab3ad206443bed01103ee5

## Docker Image ##

[![Docker Pulls](https://img.shields.io/docker/pulls/cisagov/vdp-scanner)](https://hub.docker.com/r/cisagov/vdp-scanner)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/cisagov/vdp-scanner)](https://hub.docker.com/r/cisagov/vdp-scanner)
[![Platforms](https://img.shields.io/badge/platforms-amd64%20%7C%20arm%2Fv7%20%7C%20arm64-blue)](https://hub.docker.com/r/cisagov/vdp-scanner/tags)

This is a Docker project to scan either the
[GSA current Federal .gov domain list](https://github.com/GSA/data/blob/master/dotgov-domains/current-federal.csv)
or a given CSV in the same format with the
[cisagov/hash-http-content](https://github.com/cisagov/hash-http-content)
Python library. Then it will output CSVs with agency and domain level results.

## Running ##

### Running with Docker ###

To run the `cisagov/vdp-scanner` image via Docker:

```console
docker run cisagov/vdp-scanner:0.2.0-dev.9
```

### Running with Docker Compose ###

1. Create a `compose.yml` file similar to the one below to use [Docker Compose](https://docs.docker.com/compose/).

    ```yaml
    ---
    name: vdp-scanner

    services:
      vdp-scanner:
        image: cisagov/vdp-scanner:0.2.0-dev.9
        volumes:
          - .:/task/host_mount
    ```

1. Start the container and detach:

    ```console
    docker compose up --detach
    ```

## Updating your container ##

### Docker Compose ###

1. Pull the new image from Docker Hub:

    ```console
    docker compose pull
    ```

1. Recreate the running container by following the [previous instructions](#running-with-docker-compose):

    ```console
    docker compose up --detach
    ```

### Docker ###

1. Stop the running container:

    ```console
    docker stop <container_id>
    ```

1. Pull the new image:

    ```console
    docker pull cisagov/vdp-scanner:0.2.0-dev.9
    ```

1. Recreate and run the container by following the [previous instructions](#running-with-docker).

## Updating Python dependencies ##

This image uses [Pipenv] to manage Python dependencies using a [Pipfile](https://github.com/pypa/pipfile).
Both updating dependencies and changing the [Pipenv] configuration in `src/Pipfile`
will result in a modified `src/Pipfile.lock` file that should be committed to the
repository.

### Updating dependencies ###

If you want to update existing dependencies you would run the following command
in the `src/` subdirectory:

```console
pipenv lock
```

### Modifying dependencies ###

If you want to add or remove dependencies you would update the `src/Pipfile` file
and then update dependencies as you would above.

> [!NOTE]
> You should only specify packages that are direct requirements of
> your Docker configuration. Allow [Pipenv] to manage the dependencies
> of the specified packages.

## Image tags ##

The images of this container are tagged with [semantic
versions](https://semver.org) of the underlying example project that they
containerize.  It is recommended that most users use a version tag (e.g.
`:0.2.0-dev.9`).

| Image:tag | Description |
<<<<<<< HEAD
|-----------|-------------|
|`cisagov/vdp-scanner:0.2.0-dev.9`| An exact release version. |
|`cisagov/vdp-scanner:0.2`| The most recent release matching the major and minor version numbers. |
|`cisagov/vdp-scanner:0`| The most recent release matching the major version number. |
|`cisagov/vdp-scanner:edge` | The most recent image built from a merge into the `develop` branch of this repository. |
|`cisagov/vdp-scanner:nightly` | A nightly build of the `develop` branch of this repository. |
|`cisagov/vdp-scanner:latest`| The most recent release image pushed to a container registry.  Pulling an image using the `:latest` tag [should be avoided.](https://vsupalov.com/docker-latest-tag/) |
=======
| --------- | ----------- |
| `cisagov/example:0.2.2+build.1` | An exact release version. |
| `cisagov/example:0.2` | The most recent release matching the major and minor version numbers. |
| `cisagov/example:0` | The most recent release matching the major version number. |
| `cisagov/example:edge` | The most recent image built from a merge into the `develop` branch of this repository. |
| `cisagov/example:nightly` | A nightly build of the `develop` branch of this repository. |
| `cisagov/example:latest` | The most recent release image pushed to a container registry.  Pulling an image using the `:latest` tag [should be avoided.](https://vsupalov.com/docker-latest-tag/) |
>>>>>>> cdd0eb7c54a6982e1cac5e92cb7f61d7d74c97e0

See the [tags tab](https://hub.docker.com/r/cisagov/vdp-scanner/tags) on Docker
Hub for a list of all the supported tags.

## Volumes ##

<<<<<<< HEAD
| Mount point | Purpose |
|-------------|---------|
| `/task/host_mount`  | Output directory.  |
=======
| Mount point | Purpose        |
| ----------- | -------------- |
| `/var/log`  |  Log storage   |
>>>>>>> cdd0eb7c54a6982e1cac5e92cb7f61d7d74c97e0

## Ports ##

There are no exposed ports.

<!--
The following ports are exposed by this container:

<<<<<<< HEAD
| Port | Purpose        |
|------|----------------|
| Port Number | Describe its purpose. |
-->
=======
| Port | Purpose |
| ---- | ------- |
| 8080 | Example only; nothing is actually listening on the port |

The sample [Docker composition](compose.yml) publishes the
exposed port at 8080.
>>>>>>> cdd0eb7c54a6982e1cac5e92cb7f61d7d74c97e0

## Environment variables ##

### Required ###

There are no required environment variables.

<!--
| Name  | Purpose | Default |
| ----- | ------- | ------- |
| `REQUIRED_VARIABLE` | Describe its purpose. | `null` |
-->

### Optional ###

<<<<<<< HEAD
There are no optional environment variables.

<!--
| Name  | Purpose | Default |
|-------|---------|---------|
| `OPTIONAL_VARIABLE` | Describe its purpose. | `null` |
-->

## Secrets ##

There are no secrets.

<!--
| Filename     | Purpose |
|--------------|---------|
| `filename.ext` | Describe its purpose. |
-->
=======
| Name | Purpose | Default |
| ---- | ------- | ------- |
| `ECHO_MESSAGE` | Sets the message echoed by this container. | `Hello World from Dockerfile` |

## Secrets ##

| Filename | Purpose |
| -------- | ------- |
| `quote.txt` | Replaces the secret stored in the example library's package data. |
>>>>>>> cdd0eb7c54a6982e1cac5e92cb7f61d7d74c97e0

## Building from source ##

Build the image locally using this git repository as the [build context](https://docs.docker.com/engine/reference/commandline/build/#git-repositories):

```console
docker build \
  --tag cisagov/vdp-scanner:0.2.0-dev.9 \
  https://github.com/cisagov/vdp-scanner-docker.git#develop
```

## Cross-platform builds ##

To create images that are compatible with other platforms, you can use the
[`buildx`](https://docs.docker.com/buildx/working-with-buildx/) feature of
Docker:

1. Copy the project to your machine using the `Code` button above
   or the command line:

    ```console
    git clone https://github.com/cisagov/vdp-scanner-docker.git
    cd vdp-scanner-docker
    ```

1. Create the `Dockerfile-x` file with `buildx` platform support:

    ```console
    ./buildx-dockerfile.sh
    ```

1. Build the image using `buildx`:

    ```console
    docker buildx build \
      --file Dockerfile-x \
      --platform linux/amd64 \
      --output type=docker \
      --tag cisagov/vdp-scanner:0.2.0-dev.9 .
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

[Pipenv]: https://pypi.org/project/pipenv/
