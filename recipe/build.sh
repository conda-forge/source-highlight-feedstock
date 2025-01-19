#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export CXXFLAGS="${CXXFLAGS} -Wno-register -Wno-dynamic-exception-spec"
autoreconf --force --verbose --install
./configure \
    --prefix=$PREFIX \
    --with-boost-libdir=${PREFIX}/lib
make -j${CPU_COUNT}
make install
