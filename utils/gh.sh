#!/bin/bash -uex

# https://github.com/cli/cli/releases/
VERSION="2.2.0"

ARCH="$(uname | tr '[:upper:]' '[:lower:]')_amd64"
#ARCH="$(uname | tr '[:upper:]' '[:lower:]')_arm64"
NAME="gh_${VERSION}_${ARCH}"


cd /tmp
curl -Lo "${NAME}.tgz" "https://github.com/cli/cli/releases/download/v${VERSION}/${NAME}.tar.gz"
tar xf "${NAME}.tgz" "${NAME}/bin/gh"
mv "${NAME}/bin/gh" ~/local/bin
rm -rf "${NAME}" "${NAME}.tgz"
