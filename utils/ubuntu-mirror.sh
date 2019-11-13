#!/bin/sh

perl -pi.bak -e 's!http://(archive|security)\.ubuntu\.com/ubuntu/!mirror://mirrors.ubuntu.com/mirrors.txt!g' /etc/apt/sources.list
