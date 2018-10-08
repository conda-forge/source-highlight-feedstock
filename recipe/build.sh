#!/bin/bash

export CXXFLAGS="${CXXFLAGS} -I${PREFIX}/lib"
export LDFLAGS="${LDFLAGS}"

autoreconf -i
mkdir build
cd build
../configure \
    --prefix=$PREFIX
make
make install
