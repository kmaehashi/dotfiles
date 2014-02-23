#!/bin/sh

# apt-cyg setup

wget "http://apt-cyg.googlecode.com/svn/trunk/apt-cyg"
chmod 755 apt-cyg
mv apt-cyg /bin

apt-cyg --mirror ftp://ftp.jaist.ac.jp/pub/cygwin/$(_cygarch) --cache /cygdrive/c/cygwin/cache update

