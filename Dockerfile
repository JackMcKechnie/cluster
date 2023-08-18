FROM hitt08/ubuntu-py:gpu_cuda11

RUN pip3 install -U pip setuptools wheel && pip3 install jupyter -U && pip3 install jupyterlab

COPY requirements.txt /tmp

RUN conda install -y pytorch cudatoolkit=11.3 -c pytorch && pip3 install --no-cache-dir -r /tmp/requirements.txt


WORKDIR /nfs