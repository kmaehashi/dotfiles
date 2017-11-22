#!/bin/sh

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# Examples:
# env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.6.3
# pyenv virtualenv 3.6.3 local-3.6.3
