#!/bin/bash

if [ $(uname) == Linux ]; then
  export CXXFLAGS=${CXXFLAGS/" -std=c++17"/}
fi

echo $(uname)

mkdir build
cd build
../configure \
    --prefix=$PREFIX \
    --with-boost-libdir=${PREFIX}/lib
make
make install
