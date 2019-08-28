#!/bin/sh

set -e -o pipefail

curl -L 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' > config.guess
curl -L 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD' > config.sub
./configure --prefix=$PREFIX
make
make check
make install
