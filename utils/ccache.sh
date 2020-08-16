#!/bin/bash -uex

# https://github.com/ccache/ccache/releases
VERSION="3.7.11"

mkdir -p ~/local/src
pushd ~/local/src

curl -LO "https://github.com/ccache/ccache/releases/download/v${VERSION}/ccache-${VERSION}.tar.gz"
tar xf "ccache-${VERSION}.tar.gz"
pushd ccache-${VERSION}
./configure --prefix="${HOME}/local"
make
make install

for C in gcc g++; do
    cat << _EOF_ > ~/local/bin/ccache-${C}
#!/bin/sh
exec ccache ${C} \$@
_EOF_
    chmod +x ~/local/bin/ccache-${C}
done
