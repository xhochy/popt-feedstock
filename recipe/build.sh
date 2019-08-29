#!/bin/sh

set -e -o pipefail

# If platform detection fails, these should be updated in the meta.yaml from:
# http://git.savannah.gnu.org/gitweb/?p=config.git&view=view+git+repository
mv config-updated.guess config.guess
mv config-updated.sub config.sub

./configure --prefix=$PREFIX
make
make check
make install
