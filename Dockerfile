ARG from=ubuntu:focal
FROM $from

LABEL maintainer="Christophe Trophime <christophe.trophime@lncmi.cnrs.fr>"

ARG USERNAME=feelpp
ARG VERSION=1.0.7

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get -qq update && \
    apt-get -y --no-install-recommends install sudo openssh-client

# Seup demo environment variables
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=$PATH:/home/$USERNAME/.local/bin

# to help debug but shall not be present in prod
RUN useradd -m -s /bin/bash -G sudo,video $USERNAME && \
    mkdir -p  /etc/sudoers.d/ && \
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    mkdir -p ~$USERNAME/.ssh/ && \
    ssh-keyscan github.com >> ~$USERNAME/.ssh/known_hosts && \
    chown -R $USERNAME ~$USERNAME/.ssh && \
    # install pre-requisites \
    apt-get -qq update && \
    apt-get -y upgrade && \
    apt-get -y --no-install-recommends install debian-keyring lsb-release ca-certificates wget curl tree && \
    apt-get -y --no-install-recommends install dpkg-dev bash-completion file coreutils && \
    apt-get -y --no-install-recommends install python3 python3-venv python-is-python3 && \
    apt-get -y --no-install-recommends install python3-setuptools python3-wheel && \
    # ffmpeg for matplotlib anim & dvipng+cm-super for latex labels \
    apt-get install -y --no-install-recommends ffmpeg dvipng cm-super && \
    cp /usr/share/keyrings/debian-maintainers.gpg /etc/apt/trusted.gpg.d && \
    echo "lsb_release=$(lsb_release -cs)" && \
    echo "*** install prerequisites for MagnetTools ***" && \
    echo "deb http://euler.lncmig.local/~christophe.trophime@LNCMIG.local/debian/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/lncmi.list && \
    echo "deb-src http://euler.lncmig.local/~christophe.trophime@LNCMIG.local/debian/ $(lsb_release -cs) main" >> /etc/apt/sources.list.d/lncmi.list && \
    cat /etc/apt/sources.list.d/lncmi.list && \
    apt-get -qq update

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

# create MagneTools wheel package
COPY pyproject.toml /home/${USERNAME}
COPY eps_params.dat /home/${USERNAME}
COPY test.py /home/${USERNAME}
COPY 2helix.d /home/${USERNAME}

USER $USERNAME
WORKDIR /home/$USERNAME

# Install poetry
# poetry config virtualenvs.options.system-site-packages true
RUN cd /home/${USERNAME} \
    && curl -sSL https://install.python-poetry.org | python -  \
    && poetry --version \
    && poetry completions bash >> ~/.bash_completion

# Install properly MagnetTools into poetry env
RUN cd /home/${USERNAME} \
    && mkdir -p /home/${USERNAME}/magnettools/tests \
    && cp pyproject.toml /home/${USERNAME}/magnettools \
    && cp eps_params.dat /home/${USERNAME}/magnettools/tests \
    && cp test.py /home/${USERNAME}/magnettools/tests \
    && cp 2helix.d /home/${USERNAME}/magnettools/tests \
    && cd /home/${USERNAME}/magnettools \
    && ls -lrth \
    && sudo apt -y install --no-install-recommends python3-magnettools python3-matplotlib \
    && perl -pi -e "s|version = .*$|version = \"${VERSION}\"|" pyproject.toml \
    && sudo chown -R ${USERNAME} /home/$USERNAME/magnettools \
    && echo "MagnetTools Python Bindings" > README.md \
    && cp -rp /usr/lib/python3/dist-packages/magnettools /home/$USERNAME/magnettools \
    && sudo apt -y remove python3-magnettools
#    && poetry install \
#    && cd .. \
        
Run cd /home/$USERNAME \
    && rm 2helix.d  eps_params.dat pyproject.toml  test.py

# perform cleanup
USER root
RUN apt-get -y autoclean && \
    apt-get -y clean

USER $USERNAME
WORKDIR /home/$USERNAME

# to run test
# docker run -it --rm magnettools:${VERSION}-bookworm-poetry
# Once in the container, run:
# cd /home/$USERNAME/magnettools \
# poetry run python -m magnettools.Bmap --help
# cd tests
# poetry run python test.py