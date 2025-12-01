#!/bin/bash

set -uex

VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)"

if [[ "$(uname)" = "Darwin" ]]; then
  PLAT="darwin"
else
  PLAT="linux"
fi

curl -LO "https://dl.k8s.io/release/${VERSION}/bin/${PLAT}/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/${VERSION}/bin/${PLAT}/amd64/kubectl-convert"

chmod +x kubectl kubectl-convert
mv kubectl kubectl-convert ~/local/bin
