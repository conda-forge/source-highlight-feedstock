#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

./configure \
    --prefix=$PREFIX \
    --with-boost-libdir=${PREFIX}/lib
make -j${CPU_COUNT}
make install
