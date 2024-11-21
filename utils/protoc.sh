#!/bin/bash

set -uex

VER=28.3
ARCH=linux-x86_64

curl -LO "https://github.com/protocolbuffers/protobuf/releases/download/v${VER}/protoc-${VER}-${ARCH}.zip"
unzip "protoc-${VER}-${ARCH}.zip" bin/protoc
mv bin/protoc ~/local/bin
rmdir bin
rm "protoc-${VER}-${ARCH}.zip"
