# local install

```
docker build \
  --progress=plain --no-cache \
  --build-arg from=debian:bookworm \
  --build-arg VERSION=1.1.0  \
  -f ./Dockerfile \
  -t magnettools:1.1.0-bookworm-poetry .
```

# wheel python package

MagnetTools may be installed with poetry as a wheel python package.
This requires to rebuild the MagnetTools python bindings.
Check Dockerfile to see how.


For instance:

```
docker build \
  --progress=plain --no-cache \
  --build-arg from=debian:12 \
  --build-arg VERSION=1.1.0  \
  -f ./Dockerfile-dev \
  -t magnettools:bookworm-poetry .
```

This will create a wheel in the container (in `/home/feelpp`).

## Build arguments

`Dockerfile-dev` supports the following `--build-arg` parameters:

| Argument | Default | Description |
|---|---|---|
| `from` | `ubuntu:focal` | Base image |
| `USERNAME` | `feelpp` | Non-root user created inside the image |
| `VERSION` | `1.0.6` | MagnetTools source package version |
| `python_version` | `3.11` | Python version used to build the wheel (e.g. `3.10`, `3.12`) |
| `arch` | `linux_x86_64` | Target architecture tag embedded in the wheel filename (e.g. `linux_aarch64`) |

Example targeting Python 3.12 on an ARM host:

```
docker build \
  --progress=plain --no-cache \
  --build-arg from=debian:12 \
  --build-arg VERSION=1.1.0 \
  --build-arg python_version=3.12 \
  --build-arg arch=linux_aarch64 \
  -f ./Dockerfile-dev \
  -t magnettools:bookworm-poetry-arm .
