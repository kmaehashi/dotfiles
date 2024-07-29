#!/bin/bash -uex

# https://github.com/ccache/ccache/releases
VERSION="4.8.3"

curl -L "https://github.com/ccache/ccache/releases/download/v${VERSION}/ccache-${VERSION}-linux-x86_64.tar.xz" | tar --directory ~/local/bin -xJ --strip-components 1 "ccache-${VERSION}-linux-x86_64/ccache"

for C in gcc g++; do
    cat << _EOF_ > ~/local/bin/ccache-${C}
#!/bin/sh
exec ccache ${C} \$@
_EOF_
    chmod +x ~/local/bin/ccache-${C}
done
