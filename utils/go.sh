#!/bin/bash -uex

ARCH="linux-amd64"
VERSION="1.13"
NAME="go${VERSION}.${ARCH}"

cd /tmp
wget "https://dl.google.com/go/${NAME}.tar.gz"
tar xf "${NAME}.tar.gz"
mv go ~/local
rm -rf "${NAME}"
