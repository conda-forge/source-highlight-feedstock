#!/bin/bash

if [ $(uname) == Linux ]; then
  export CXXFLAGS="${CXXFLAGS/" -std=c++17"/} -I${PREFIX}/include/boost"
  export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
fi

echo $(uname)
echo $CXXFLAGS
echo $LDFLAGS

mkdir build
cd build
../configure \
    --prefix=$PREFIX \
    --with-boost-libdir=${PREFIX}/lib
make
make install
