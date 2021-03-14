#!/bin/sh

PREFIX="$1"
HOST=$(uname -m)

OPENSSL_LIB_DIR=/usr/lib/$HOST-linux-gnu OPENSSL_INCLUDE_DIR=/usr/include ./x.py build

