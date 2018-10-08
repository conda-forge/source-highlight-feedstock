#!/bin/bash

export CFLAGS="${CFLAGS} -I${PREFIX}/lib"
export CXXFLAGS="${CXXFLAGS} -I${PREFIX}/lib"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"

autoreconf -i
mkdir build
cd build
../configure \
    --prefix=$PREFIX
make
make install
