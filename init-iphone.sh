#!/bin/sh

os=$(uname)

export work_base=~/Work/iPhone

if [ $os = "Darwin" ]; then
    ASPEN_ROOT=/Developer/Platforms/iPhoneOS.platform/Developer
    ASPEN_SDK=$ASPEN_ROOT/SDKs/iPhoneOS2.0.sdk

    export PATH="${ASPEN_ROOT}/usr/bin":"${PATH}"

    export C_INCLUDE_PATH="$ASPEN_SDK/usr/lib/gcc/arm-apple-darwin9/4.0.1/include:$ASPEN_SDK/usr/include"
    export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH

    export CC=arm-apple-darwin9-gcc-4.0.1
    export CXX=arm-apple-darwin9-g++-4.0.1
    export AR=ar
    export STRIP=strip

    export CFLAGS="-arch armv6 -isysroot $ASPEN_SDK"
    export LDFLAGS="-Wl,-syslibroot,$ASPEN_SDK"
else
    export iphone_base=~/iphone
    export prefix=$iphone_base/pre
    export sysroot=$iphone_base/sys

    export PATH="${prefix}/bin":"${PATH}"

    export CC=arm-apple-darwin9-gcc
    export CXX=arm-apple-darwin9-g++
    export AR=arm-apple-darwin9-ar
    export STRIP=arm-apple-darwin9-strip

    export CFLAGS="-march=armv6"
fi

export LD=$CC

export gc_lib_path=$work_base/gc/.libs
export gc_inc_path=$work_base/gc

export IPHONE=1

#	#export CPP="cpp-4.0 -nostdinc -U__powerpc__ -U__i386__ -D__arm__"
#	#export CXXPP="cpp-4.0 -nostdinc -U__powerpc__ -U__i386__ -D__arm__"
#	export LD=$CC
