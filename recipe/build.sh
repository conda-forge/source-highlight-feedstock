#!/bin/bash

if [ $(uname) == Linux ]; then
  export CXXFLAGS="${CXXFLAGS/" -std=c++17"/}"
  export LDFLAGS="$LDFLAGS -Wl,-rpath-link,$PREFIX/lib"
  # TODO: remove this hack and fix the build system issue with gcc7 compiler flags
  export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
fi

mkdir build
cd build
../configure \
    --prefix=$PREFIX \
    --with-boost-libdir=${PREFIX}/lib
make
make install
