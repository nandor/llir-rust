#!/bin/sh

PREFIX="$1"
HOST=$(uname -m)

export OPENSSL_LIB_DIR=/usr/lib/$HOST-linux-gnu
export OPENSSL_INCLUDE_DIR=/usr/include

if [ "$HOST" == "$ARCH" ]; then
  exit 1
else

./x.py install

mkdir -p $PREFIX/.cargo

cat >$PREFIX/.cargo/config.toml <<EOL
[build]
target = "$ARCH-unknown-linux-musl"

[target.$ARCH-unknown-linux-musl]
linker = "$ARCH-unknown-linux-musl-gcc"

[target.$HOST-unknown-linux-gnu]
linker = "rust-host-linker"

EOL

cat >$PREFIX/bin/rust-host-linker <<EOL
#!/bin/sh
gcc -L$PREFIX/llvm/lib -Wl,-rpath=/lib/x86_64-linux-gnu \$@
EOL
chmod a+x $PREFIX/bin/rust-host-linker

fi
