#!/bin/bash -uex

# https://github.com/ccache/ccache/releases
VERSION="4.4.2"

mkdir -p ~/local/src
pushd ~/local/src

curl -LO "https://github.com/ccache/ccache/releases/download/v${VERSION}/ccache-${VERSION}.tar.gz"
tar xf "ccache-${VERSION}.tar.gz"
pushd ccache-${VERSION}
unset CC
unset CXX
mkdir build
pushd build
cmake -DCMAKE_BUILD_TYPE=Release -DZSTD_FROM_INTERNET=ON -DREDIS_STORAGE_BACKEND=OFF ..
make
cp ccache ~/local/bin
popd

for C in gcc g++; do
    cat << _EOF_ > ~/local/bin/ccache-${C}
#!/bin/sh
exec ccache ${C} \$@
_EOF_
    chmod +x ~/local/bin/ccache-${C}
done
