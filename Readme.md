MagnetTools may be installed with poetry as a wheel python package.
Check Dockerfile to see how.



docker build \
  --build-arg from=debian:bullseye \
  --build-arg VERSION=1.0.7  \
  -f ./Dockerfile-dev \
  -t magnettools:bullseye-poetry .