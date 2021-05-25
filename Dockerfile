FROM debian:bullseye-slim

RUN apt-get update -y && apt-get install -y \
	gcc \
	g++ \
	git \
	libstdc++6 \
	cmake \
	libboost-all-dev \
	libjsoncpp-dev


LABEL license="https://github.com/phspo/ckmertools/blob/master/LICENSE.MD && https://github.com/phspo/ckmertools/blob/master/src/ctpl/LICENSE"
LABEL website="https://github.com/phspo/ckmertools"

RUN apt-get install -y bash

RUN git clone https://github.com/rogersce/cnpy.git && \
  mkdir cnpy/build && \
  cd cnpy/build && git checkout 4e8810b1a8637695171ed346ce68f6984e585ef4 && \
  cmake .. && \
  make && \
  make install && \
  echo "/usr/local/lib" >> /etc/ld.so.conf.d/cnpy.conf && \
  ldconfig

RUN git clone https://github.com/phspo/ckmertools.git && \
  cd ckmertools && \
  git checkout 02b106e2cf1150082bc585864f57c0283a78eb18 && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make

ENV PATH="/ckmertools/build:${PATH}"

