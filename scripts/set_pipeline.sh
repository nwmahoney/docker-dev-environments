#!/usr/bin/env bash

set -eu -o pipefail

function main {
  fly -t tutorial set-pipeline \
    --var="private-key=$(cat ~/.ssh/id_ed25519)" \
    --var="private-key-passphrase=$(op get item 'ssh passphrase (Linux Mint)' | jq -r .details.password)" \
    --var="docker-password=$(op get item Docker | jq -r '.details.fields | .[] |  select(.designation == \"password\") | .value')" \
    -p docker-dev-environments \
    -c docker-dev-environments.yml
}

main "$@"

