#!/bin/sh

PREFIX="$1"
HOST=$(uname -m)
PWD=$(pwd)

if [ "$HOST" == "$ARCH" ]; then
  exit 1
else

cat >config.toml <<EOL
[llvm]
targets = "AArch64;PowerPC;RISCV;X86;LLIR"

[build]
build = "$HOST-unknown-linux-gnu"
host = ["$HOST-unknown-linux-gnu"]
target = ["$ARCH-unknown-linux-musl"]
extended = true
tools = ["cargo"]
docs = false

[target.$HOST-unknown-linux-gnu]
llvm-config = "$PREFIX/bin/llvm-config"
cc = "$PWD/wrapper-gcc"
cxx = "$PWD/wrapper-g++"
linker = "$PWD/wrapper-ld-gcc"
ranlib = "ranlib"
ar = "ar"

[target.$ARCH-unknown-linux-musl]
llvm-config = "$PREFIX/bin/llvm-config"
cc = "$ARCH-unknown-linux-musl-gcc"
cxx = "$ARCH-unknown-linux-g++"
linker = "$ARCH-unknown-linux-musl-gcc"
ranlib = "$ARCH-unknown-linux-ranlib"
ar = "$ARCH-unknown-linux-ar"

[rust]
musl-root = "$PREFIX"
llvm-libunwind = "system"

[install]
prefix = "$PREFIX"
sysconfdir = "etc"
EOL

cat >wrapper-gcc <<EOL
#!/bin/sh
gcc -L$PREFIX/llvm/lib \$@
EOL
chmod a+x wrapper-gcc

cat >wrapper-g++ <<EOL
#!/bin/sh
g++ -L$PREFIX/llvm/lib \$@
EOL
chmod a+x wrapper-g++

cat >wrapper-ld-gcc <<EOL
#!/bin/sh
gcc -L$PREFIX/llvm/lib -Wl,-rpath=/lib/x86_64-linux-gnu \$@
EOL
chmod a+x wrapper-ld-gcc

fi
