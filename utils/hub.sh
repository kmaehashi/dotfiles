#!/bin/bash -uex

# https://github.com/github/hub/releases/
VERSION="2.14.2"

ARCH="$(uname | tr '[:upper:]' '[:lower:]')-amd64"
NAME="hub-${ARCH}-${VERSION}"

cd /tmp
curl -Lo "${NAME}.tgz" "https://github.com/github/hub/releases/download/v${VERSION}/${NAME}.tgz"
tar xf "${NAME}.tgz" "${NAME}/bin/hub"
mv "${NAME}/bin/hub" ~/local/bin
rm -rf "${NAME}" "${NAME}.tgz"
