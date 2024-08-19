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
  --build-arg from=debian:bookworm \
  --build-arg VERSION=1.1.0  \
  -f ./Dockerfile-dev \
  -t magnettools:bookworm-poetry .
```

This will create a wheel in the container (in `/home/feelpp`)
