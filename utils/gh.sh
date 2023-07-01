#!/bin/bash -uex

# https://github.com/cli/cli/releases/
VERSION="$(curl -f -s 'https://api.github.com/repos/cli/cli/releases/latest' | grep '"tag_name":' | cut -f4 -d'"' | tr -d v)"

if [[ "$(uname)" = "Darwin" ]]; then
    OSNAME="macOS"
    ARCH="macOS_arm64"
    EXT="zip"
else
    OSNAME="$(uname | tr '[:upper:]' '[:lower:]')"
    ARCH="${OSNAME}_amd64"
    EXT="tar.gz"
fi

NAME="gh_${VERSION}_${ARCH}"

WORKDIR="$(mktemp -d)"
pushd "${WORKDIR}"
curl -fL -o "archive" "https://github.com/cli/cli/releases/download/v${VERSION}/${NAME}.${EXT}"
tar xf "./archive" "${NAME}/bin/gh"
mv "${NAME}/bin/gh" ~/local/bin
popd
rm -rf "${WORKDIR}"
