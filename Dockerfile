FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
ENV NVIDIA_DRIVER_CAPABILITIES all
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    apt-utils \
    nano \
    git \
    curl && \
    apt-get autoremove && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata && \
    rm -rf /var/lib/apt/lists/*
RUN useradd -m -d /home/ubuntu ubuntu -p $(perl -e 'print crypt("ubuntu", "salt"),"\n"') && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install ROS1 and ROS2
RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y \
    x11-apps \
    tmux \
    build-essential \
    ccache \
    cmake \
    git \
    pkg-config \
    wget \
    unzip \
    mlocate \
    sudo \
    gdb \
    && apt-get clean

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y \
    nano \
    gedit \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libffi-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    libxml2-dev


# Install Python3
RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3-pip \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev

# Install Python's library package
RUN pip3 install --upgrade pip 
RUN pip3 install \
    setuptools \
    numpy \
    six \
    scipy \
    matplotlib \
    pandas \
    lxml \
    tqdm \
    pybind11 \
    chainer==6.5.0 \
    pybullet \
    gym \
    ipython \
    pygame

RUN apt-get update && apt-get install -y \
    mpi \
    python3-mpi4py

RUN pip3 install \
    bayesian-optimization \
    tqdm


WORKDIR /home/ubuntu
RUN git clone http://github.com/chainer/chainerrl chainerrl
WORKDIR /home/ubuntu/chainerrl
RUN python3 setup.py install

# Install pytorch
RUN pip install torch==1.5.0+cpu torchvision==0.6.0+cpu \
    -f https://download.pytorch.org/whl/torch_stable.html

# Install vscode
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
RUN sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y code # or code-insiders

RUN pip install \
    tensorflow==1.14 \
    tensorflow-gpu==1.14

ENV USER ubuntu
