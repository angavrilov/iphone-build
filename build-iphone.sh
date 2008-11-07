#!/bin/bash

source init-iphone.sh

# MAKE GC
cd gc

if [ -n "$STATICLIB" ]; then
    ./configure $HOST --enable-shared=no --enable-cplusplus=no --enable-full-debug=yes
else
    ./configure $HOST --enable-shared=yes --enable-cplusplus=no --enable-full-debug=yes
fi

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
    cp -f gc/.libs/libgc.a neko/bin/libneko.a neko/libs/std/*.o neko/bin/neko libs
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

