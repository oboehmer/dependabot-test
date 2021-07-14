FROM ubuntu:20.04

# ----------------------- Builder image start ---------------------------
# This container is used to build the python virtualenv which is copied 
# to the CXTA container as well as to build+cythonize CXTA package.
# 
# We do this to reduce the final container size by the development environment (gcc & friends)

# No tty during docker build, so instruct package installers we're in non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install basic packages to be able to pull in software and build packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        autoconf \
        automake \
        build-essential \
        checkinstall \
        curl \
        git \
        libbz2-dev \
        libc6-dev \
        libffi-dev \
        libgdbm-dev \
        libncursesw5-dev \
        libpq-dev \
        libreadline-gplv2-dev \
        libsqlite3-dev \
        libtool \
        libxml2-dev \
        libxslt-dev \
        lsb-core \
        make \
        software-properties-common \
        tk-dev

# FPM to build debian packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends ruby ruby-dev rubygems
RUN gem install --no-document fpm

# Install python3
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-dev python3-venv python3-pip python3-tk
RUN pip3 install setuptools wheel

