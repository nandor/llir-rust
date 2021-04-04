#!/bin/sh

PREFIX="$1"
HOST=$(uname -m)

export OPENSSL_LIB_DIR=/usr/lib/$HOST-linux-gnu
export OPENSSL_INCLUDE_DIR=/usr/include

./x.py build

