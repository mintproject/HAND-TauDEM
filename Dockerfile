FROM continuumio/miniconda3
# ------
# TauDEM
# ------

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade -y --allow-unauthenticated && \
    apt-get install -y --allow-unauthenticated \
        build-essential \
        cmake \
        curl \
        git \
        libfreetype6-dev \
        libgdal-dev \
        libgdal-dev \
        libpng-dev \
        libssl-dev \
        libsundials-dev \
        libomp-dev \
        libopenmpi-dev \
        libxpm-dev \
        libzmq3-dev \

RUN git clone --branch Develop https://github.com/dtarb/TauDEM && \
    cd TauDEM/src && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install && \
    cd ../../.. && \
    rm -rf TauDEM

ADD environment.yml /tmp/environment.yml
RUN conda env update -f /tmp/environment.yml
ADD scripts/ ./
RUN mv /usr/local/taudem/* /usr/local/bin/
