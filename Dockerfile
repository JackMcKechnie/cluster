FROM hitt08/ubuntu-py:gpu_cuda11

RUN apt install python3.10 && pip3 install -U pip setuptools wheel && pip3 install jupyter -U && pip3 install jupyterlab

COPY requirements.txt /tmp

RUN conda install -y pytorch cudatoolkit=11.3 -c pytorch && pip3 install --no-cache-dir -r /tmp/requirements.txt

RUN conda install pytorch==1.12.1 cudatoolkit=11.3 -c pytorch -y

WORKDIR /nfs

ENV JAVA_HOME="/nfs/java/jdk-11.0.1"

RUN pip uninstall -y neptune-client && pip install -U neptune pyserini pytorch-lightning
