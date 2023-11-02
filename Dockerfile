FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    devscripts \
    dpkg-dev \
    debhelper \
    dh-python \
    python3-all \
    python3-setuptools \
    python3-dev


COPY . /app

WORKDIR /app

RUN dpkg-buildpackage -us -uc

RUN cp ../*.deb /app/

RUN dpkg -i /app/python-barcode_0.15.1_all.deb

RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN find /app/debian -type f -exec chmod 644 {} \;
RUN find /app/debian -type d -exec chmod 755 {} \;

CMD ["/bin/bash"]
