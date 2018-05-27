#!/bin/bash -uex

ARCH="linux-amd64"
VERSION="2.2.9"
NAME="hub-${ARCH}-${VERSION}"

cd /tmp
wget "https://github.com/github/hub/releases/download/v${VERSION}/${NAME}.tgz"
tar xf "${NAME}.tgz" "${NAME}/bin/hub"
mv "${NAME}/bin/hub" ~/local/bin
rm -rf "${NAME}"
