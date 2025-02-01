FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu20.04

WORKDIR /workspace

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    git \
    libopencv-dev \
    unzip \
    && wget https://github.com/Kitware/CMake/releases/download/v3.18.0/cmake-3.18.0-Linux-x86_64.tar.gz \
    && tar -xzvf cmake-3.18.0-Linux-x86_64.tar.gz \
    && mv cmake-3.18.0-Linux-x86_64 /opt/cmake-3.18 \
    && ln -s /opt/cmake-3.18/bin/cmake /usr/local/bin/cmake \
    && rm -rf cmake-3.18.0-Linux-x86_64.tar.gz \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://download.pytorch.org/libtorch/cu124/libtorch-cxx11-abi-shared-with-deps-2.6.0%2Bcu124.zip -O libtorch.zip \
    && unzip libtorch.zip && rm libtorch.zip

ENV LIBTORCH_PATH=/workspace/libtorch
ENV PATH=$LIBTORCH_PATH/bin:$PATH
ENV LD_LIBRARY_PATH=$LIBTORCH_PATH/lib:$LD_LIBRARY_PATH
ENV CMAKE_PREFIX_PATH=$LIBTORCH_PATH/share/cmake/Torch

CMD ["/bin/bash"]
