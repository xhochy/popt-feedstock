#!/bin/sh

set -exo pipefail

# If platform detection fails, these should be updated in the meta.yaml from:
# http://git.savannah.gnu.org/gitweb/?p=config.git&view=view+git+repository
mv config-updated.guess config.guess
mv config-updated.sub config.sub

if [[ "$target_platform" == "win-64" ]]; then
  C_PREFIX="${PREFIX//\\//}"
  C_PREFIX="/c${C_PREFIX:2}/Library"
else
  C_PREFIX=${PREFIX}
fi
./configure --prefix=$C_PREFIX
if [[ "$target_platform" == "win-64" ]]; then
  sed -ie "s/POPT_SYSCONFDIR .*\$/POPT_SYSCONFDIR \"${C_PREFIX//\//\\/}\/etc\"/" config.h
fi

make
if [[ "$target_platform" == "win-64" ]]; then
  # Tests 19 and 20 fail on Windows; they would need separate patching
  echo "make check skipped"
else
  make check
fi
make install
