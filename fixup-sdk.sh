#!/bin/bash

source init-iphone.sh

if [ -z "$ASPEN_SDK" ]; then
    echo Not a MacOS!
    exit 1
fi

cd $ASPEN_SDK/usr/lib

ln -s dylib1.o         dylib1.10.5.o
ln -s libgcc_s.1.dylib libgcc_s.10.5.dylib
ln -s crt1.o           crt1.10.5.o
