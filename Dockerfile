FROM debian:bullseye-slim

RUN     apt-get update -y && apt-get install -y \
	gcc \
	g++ \
	git \
	libstdc++6 \
	cmake \
	libboost-all-dev \
	libjsoncpp-dev


LABEL license="https://github.com/phspo/ckmertools/blob/master/LICENSE.MD && https://github.com/phspo/ckmertools/blob/master/src/ctpl/LICENSE"
LABEL website="https://github.com/phspo/ckmertools"

RUN git clone https://github.com/phspo/ckmertools.git && \
  cd ckmertools && \
  git checkout 9395c1205429f2aa1c6fe94231028a1e4ec976af

RUN apt-get install -y bash

RUN cd ckmertools && \  
  mkdir build && \
  cd build && \
  cmake ../ && \
  make

ENV PATH="/ckmertools/build:${PATH}"

