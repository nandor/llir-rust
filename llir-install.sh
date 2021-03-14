#!/bin/sh

PREFIX="$1"
HOST=$(uname -m)

OPENSSL_LIB_DIR=/usr/lib/$HOST-linux-gnu OPENSSL_INCLUDE_DIR=/usr/include ./x.py install

mkdir -p $PREFIX/.cargo

cat >$PREFIX/.cargo/config.toml <<EOL
[build]
target = "$ARCH-unknown-linux-musl"

[target.$ARCH-unknown-linux-musl]
linker = "$ARCH-unknown-linux-musl-gcc"

EOL
