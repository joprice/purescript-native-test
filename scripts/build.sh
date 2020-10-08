#!/usr/bin/env bash

set -eu

find . -name "spago.dhall" | xargs dirname | xargs -n1 bash -c 'cd $0 && echo "building $0" && spago build'
