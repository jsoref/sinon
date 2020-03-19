#!/bin/bash

# Link 'sinon' to local development dir
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/.."
npm link

# Install examples project and link to local sinon folder
cd "$SCRIPT_DIR"
npm install
npm link sinon

# Make sure all examples are still runnable
set -e
for f in *.test.js; do
    node $f
done
set +e

# clean up to avoid circular links confusing watchers
npm unlink sinon
git checkout -- package.json
npm install
cd "$SCRIPT_DIR/.."
npm unlink
