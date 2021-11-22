#!/bin/bash -uex

# https://golang.org/dl/
VERSION="1.17.3"

ARCH="$(uname | tr '[:upper:]' '[:lower:]')-amd64"
NAME="go${VERSION}.${ARCH}"

[ -d ~/local/go ] && echo "Go already installed: ~/local/go" && exit

cd /tmp
curl -O "https://dl.google.com/go/${NAME}.tar.gz"
tar xf "${NAME}.tar.gz"
mv go ~/local
rm -rf "${NAME}.tar.gz"
