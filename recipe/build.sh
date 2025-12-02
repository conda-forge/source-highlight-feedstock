#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

if [[ ${CONDA_BUILD_CROSS_COMPILATION:-0} == 1 ]]; then
    CROSS_CFLAGS=${CFLAGS}
    CROSS_CXXFLAGS=${CXXFLAGS}
    CROSS_LDFLAGS=${LDFLAGS}
    CROSS_CC="${CC}"
    CROSS_CXX="${CXX}"
    CROSS_LD="${LD}"

    CFLAGS=${CFLAGS//${PREFIX}/${BUILD_PREFIX}}
    CXXFLAGS=${CXXFLAGS//${PREFIX}/${BUILD_PREFIX}}
    LDFLAGS=${LDFLAGS//${PREFIX}/${BUILD_PREFIX}}
    CC=${CC//${CONDA_TOOLCHAIN_HOST}/${CONDA_TOOLCHAIN_BUILD}}
    CXX=${CXX//${CONDA_TOOLCHAIN_HOST}/${CONDA_TOOLCHAIN_BUILD}}
    LD="${LD//${CONDA_TOOLCHAIN_HOST}/${CONDA_TOOLCHAIN_BUILD}}"

    export CXXFLAGS="${CXXFLAGS} -std=c++11"
    autoreconf --force --verbose --install
    ./configure \
        --prefix=$BUILD_PREFIX \
        --with-boost-libdir=${BUILD_PREFIX}/lib
    make -j${CPU_COUNT}
    make install
    make clean

    CFLAGS=${CROSS_CFLAGS}
    CXXFLAGS=${CROSS_CXXFLAGS}
    LDFLAGS="${CROSS_LDFLAGS}"
    CC=${CROSS_CC}
    CXX=${CROSS_CXX}
    LD=${CROSS_LD}

    sed -i "s?\$(top_builddir)/src?${BUILD_PREFIX}/bin?" doc/Makefile.am
fi

export CXXFLAGS="${CXXFLAGS} -std=c++11"
autoreconf --force --verbose --install
./configure \
    --prefix=$PREFIX \
    --with-boost-libdir=${PREFIX}/lib
make -j${CPU_COUNT}
make install
