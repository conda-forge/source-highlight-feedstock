#!/bin/bash

if [ $(uname) == Linux ]; then
  export CXXFLAGS="${CXXFLAGS/" -std=c++17"/} -std=c++11"
fi

mkdir build
cd build
../configure \
    --prefix=$PREFIX \
    --with-boost-libdir=${PREFIX}/lib
make
make install
