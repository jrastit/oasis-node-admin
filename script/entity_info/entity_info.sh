#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh
$SCRIPT_DIR/myoasis.sh stake account info 
# STAKE_ADDRESS=`$SCRIPT_ENTITY_INFO_DIR/get_entity_address.sh`
# echo $STAKE_ADDRESS
# $SCRIPT_DIR/cli_local.sh account show $STAKE_ADDRESS --network testnet --show-delegations 
# $SCRIPT_DIR/mycli_local.sh account show | sed "s/=== CONSENSUS LAYER (mainnet) ===/mainnet:/" | sed "s/=== sapphire PARATIME ===/sapphire:/" | sed "s/%//" | sed "s/(1)/   /" | sed "s/(2)/   /" | yq
