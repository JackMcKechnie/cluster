FROM nvidia/cuda:11.2.2-devel-ubuntu20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    build-essential \
    curl \ 
    zip unzip\
    openjdk-8-jre \
    git-lfs \
    vim \
    software-properties-common \
    locales

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN locale-gen en_US.UTF-8
ENV LANGUAGE en_US:en
ENV PATH="/root/miniconda/bin:${PATH}"
ARG PATH="/root/miniconda/bin:${PATH}"
    
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh -o /tmp/Miniconda3-py38_4.12.0-Linux-x86_64.sh && \
	bash /tmp/Miniconda3-py38_4.12.0-Linux-x86_64.sh -b -p $HOME/miniconda && rm /tmp/Miniconda3-py38_4.12.0-Linux-x86_64.sh

RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update && apt-get install -y --no-install-recommends python3-venv python3-pip gcc python3-dev
RUN apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip setuptools wheel && pip3 install jupyter -U && pip3 install jupyterlab

COPY requirements.txt /tmp

RUN conda install -y pytorch cudatoolkit=11.3 -c pytorch && pip3 install --no-cache-dir -r /tmp/requirements.txt


WORKDIR /nfs