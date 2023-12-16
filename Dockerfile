# Use a base image with build tools and dependencies
FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
ENV RISCV=/opt/riscv
ENV PATH=$RISCV/bin:$PATH
WORKDIR $RISCV

# Install necessary dependencies (GCC, RISC-V toolchain, etc.)
RUN apt-get update \
    && mkdir -p /usr/share/man/man1 \
    && apt-get install -y \
               apt-transport-https \
               bzip2 \
               ca-certificates \
               curl \
               git \
               gnupg \
               gzip \
               locales \
               mercurial \
               netcat \
               net-tools \
               openssh-client \
               parallel \
               sudo \
               tar \
               unzip \
               wget \
               xvfb \
               zip

# Install RISCV toolchain apt packages
RUN apt-get install -y \
            autoconf \
            automake \
            autotools-dev \
            babeltrace \
            bc \
            bison \
            build-essential \
            curl \
            device-tree-compiler \
            expat \
            flex \
            gawk \
            gperf \
            libexpat-dev \
            libgmp-dev \
            libmpc-dev \
            libmpfr-dev \
            libtool \
            libusb-1.0-0-dev \
            patchutils \
            pkg-config \
            python3 \
            python3-pip \
            texinfo \
            zlib1g-dev

# Pip install dependencies
RUN pip3 install \
            pyelftools \
            pyyaml \
            requests \
            toml \ 
            pexpect
# Install RISCV toolchain from source

# Install apt packages for yosys
RUN apt-get update \
    && mkdir -p /usr/share/man/man1 \
    && apt-get install -y \
               build-essential \
               bison \
               clang \
               flex \
               gawk \
               git \
               graphviz \
               libffi-dev \
               libreadline-dev \
               pkg-config \
               python3 \
               tcl-dev \
               xdot

# Install verilator dependencies
# Covered by the above apt get installs

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Use unicode
RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

# Add riscvuser
RUN groupadd --gid 3434 riscvuser \
    && useradd --uid 3434 --gid riscvuser --shell /bin/bash --create-home riscvuser \
    && echo 'riscvuser ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-riscvuser \
    && echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

RUN apt-get install -y gcc-riscv64-unknown-elf
# Install riscv-tools
RUN git clone https://github.com/riscv/riscv-gnu-toolchain
RUN cd riscv-gnu-toolchain && ./configure --with-arch=rv32gc --with-abi=ilp32d --enable-multilib && make


# Set working directory
WORKDIR /build-here
