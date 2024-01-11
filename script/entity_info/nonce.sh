#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
# NONCE=`$SCRIPT_DIR/myoasis.sh stake account nonce`
JSON=`$SCRIPT_DIR/mycli_local.sh account show | sed "s/=== CONSENSUS LAYER (mainnet) ===/mainnet:/" | sed "s/=== sapphire PARATIME ===/sapphire:/" | sed "s/%//" | sed "s/(1)/   /" | sed "s/(2)/   /" | yq`
NONCE=`echo -e "$JSON" | jq ".mainnet.Nonce"`
echo "$NONCE"

sleep 1
