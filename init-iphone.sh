#!/bin/sh

export iphone_base=~/iphone
export work_base=~/Work/iPhone

export prefix=$iphone_base/pre
export sysroot=$iphone_base/sys
export PATH="${prefix}/bin":"${PATH}"

export CC=arm-apple-darwin9-gcc
export CXX=arm-apple-darwin9-g++
export LD=$CC
export AR=arm-apple-darwin9-ar
export STRIP=arm-apple-darwin9-strip
export CFLAGS="-march=armv6"

export gc_lib_path=$work_base/gc/.libs
export gc_inc_path=$work_base/gc

export IPHONE=1

#	export C_INCLUDE_PATH="$ASPEN_SDK/usr/lib/gcc/arm-apple-darwin9/4.0.1/include:$ASPEN_SDK/usr/include"
#	export CPLUS_INCLUDE_PATH="$ASPEN_SDK/usr/lib/gcc/arm-apple-darwin9/4.0.1/include:$ASPEN_SDK/usr/include"
#	#export CPP="cpp-4.0 -nostdinc -U__powerpc__ -U__i386__ -D__arm__"
#	#export CXXPP="cpp-4.0 -nostdinc -U__powerpc__ -U__i386__ -D__arm__"
#	export CFLAGS="-arch armv6 -isysroot $ASPEN_SDK"
#	export LD=$CC
#	#export LDFLAGS="-Wl,-syslibroot,$ASPEN_SDK"
