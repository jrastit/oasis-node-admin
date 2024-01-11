#!/bin/bash
SCRIPT_ENTITY_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
$SCRIPT_ENTITY_INFO_DIR/entity_info.sh | awk 'ct == 2 {print gensub(/\./, "", "g", $2), $3} ct == 2 {ct = 0} ct == 1 && $2 ~ /To:/{ct++} /Active Delegations from this Account\:/{ct = 1}'
# $SCRIPT_ENTITY_INFO_DIR/entity_info.sh | jq --raw-output '.mainnet."Active Delegations from this Account".Delegations[0].Amount' | egrep -o '\((.*)\)' | cut -d ' ' -f 1 | cut -d '(' -f 2
