#!/bin/bash

source init-iphone.sh

# MAKE GC
cd gc

# configure
CFG_FLAGS=$HOST
[ -z "$NO_THREADS" ] || CFG_FLAGS="$CFG_FLAGS --enable-threads=no"

if [ -n "$STATICLIB" ]; then
    CFG_FLAGS="$CFG_FLAGS --enable-shared=no"
else
    CFG_FLAGS="$CFG_FLAGS --enable-shared=yes"
fi

./configure $CFG_FLAGS --enable-cplusplus=no --enable-full-debug=yes

# build
make clean
nice make libdir=@executable_path -j4 || exit 1
ln -s include gc

# MAKE NEKO
cd ../neko

make clean

if [ -z "$STATICLIB" ]; then
    cd bin
    for i in ../../gc/.libs/*.dylib; do ln -s $i; done
    cd ..
fi

nice make -j4 || exit 1

# COPY LIBS
cd ..

rm -rf libs
mkdir -p libs
if [ -n "$STATICLIB" ]; then
    cp -f gc/.libs/libgc.a neko/bin/libneko.a neko/bin/libnekostd.a neko/bin/neko libs
else
    cp -fR gc/.libs/libgc*.dylib neko/bin/libneko.dylib neko/bin/std.ndll neko/bin/neko libs
fi

if [ -n "$1" ]; then
    TAIL="$1"
elif [ -n "$STATICLIB" ]; then
    TAIL="static"
else
    TAIL="dynamic"
fi

if [ $os = "Darwin" ]; then
    PFIX="mac"
else
    PFIX="linux"
fi

cd libs
tar -cvzf ../$PFIX-neko-$ARCH-$TAIL.tar.gz .

cd ..

