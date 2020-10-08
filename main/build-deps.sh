#!/usr/bin/env bash

set -eu

spago ls packages -j \
  | jq  -s '[.[] | .packageName | select(. != "main" and (startswith("node-") | not))]' \
  | json-to-dhall \
  > deps.json
json-to-dhall < deps.json > deps.dhall
rm deps.json
