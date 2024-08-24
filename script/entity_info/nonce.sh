#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh
# NONCE=`$SCRIPT_DIR/myoasis.sh stake account nonce`
#JSON=`$SCRIPT_DIR/mycli_local.sh account show --network $OASIS_NODE_NETWORK | sed "s/=== CONSENSUS LAYER ($OASIS_NODE_NETWORK) ===/$OASIS_NODE_NETWORK:/" | sed "s/=== sapphire PARATIME ===/sapphire:/" | sed "s/%//" | sed "s/(1)/   /" | sed "s/(2)/   /" | yq`
#NONCE=`echo -e "$JSON" | jq ".$OASIS_NODE_NETWORK.Nonce"`
#echo "$NONCE"
echo "97"

sleep 1
