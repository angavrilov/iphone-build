#!/bin/sh

os=$(uname)

export work_base=~/Work/iPhone

if [ $os = "Darwin" ]; then
    if [ -n "$SIMULATOR" ]; then
        ASPEN_ROOT=/Developer/Platforms/iPhoneSimulator.platform/Developer
        ASPEN_SDK=$ASPEN_ROOT/SDKs/iPhoneSimulator2.0.sdk

        export C_INCLUDE_PATH="$ASPEN_SDK/usr/lib/gcc/i686-apple-darwin9/4.0.1/include:$ASPEN_SDK/usr/include"
        ARCH=i686
	HOST=
	COMPILER=i686-apple-darwin9
    else
        ASPEN_ROOT=/Developer/Platforms/iPhoneOS.platform/Developer
        ASPEN_SDK=$ASPEN_ROOT/SDKs/iPhoneOS2.0.sdk

        export C_INCLUDE_PATH="$ASPEN_SDK/usr/lib/gcc/arm-apple-darwin9/4.0.1/include:$ASPEN_SDK/usr/include"
	ARCH=armv6
	HOST=--host=arm-apple-darwin9
	COMPILER=arm-apple-darwin9
    fi

    export PATH="${ASPEN_ROOT}/usr/bin":"${PATH}"

    export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH

    export CC=${COMPILER}-gcc-4.0.1
    export CXX=${COMPILER}-g++-4.0.1
    export AR=ar
    export STRIP=strip

    export CFLAGS="-arch $ARCH -isysroot $ASPEN_SDK"
    export LDFLAGS="-Wl,-syslibroot,$ASPEN_SDK"
else
    export iphone_base=~/iphone
    export prefix=$iphone_base/pre
    export sysroot=$iphone_base/sys

    export PATH="${prefix}/bin":"${PATH}"

    ARCH=armv6
    HOST=--host=arm-apple-darwin9
    COMPILER=arm-apple-darwin-9

    export CC=${COMPILER}-gcc
    export CXX=${COMPILER}-g++
    export AR=${COMPILER}-ar
    export STRIP=${COMPILER}-strip

    export CFLAGS="-march=$ARCH"
fi

export LD=$CC

export gc_lib_path=$work_base/gc/.libs
export gc_inc_path=$work_base/gc

export IPHONE=1

#	#export CPP="cpp-4.0 -nostdinc -U__powerpc__ -U__i386__ -D__arm__"
#	#export CXXPP="cpp-4.0 -nostdinc -U__powerpc__ -U__i386__ -D__arm__"
#	export LD=$CC
