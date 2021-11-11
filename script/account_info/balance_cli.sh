#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

ESCROW_ACCOUNT=`$SCRIPT_ACCOUNT_INFO_DIR/get_entity_address.sh`
$OASIS_NODE_CLI accounts show $ESCROW_ACCOUNT | grep -A 3 "cipher PARATIME" | grep native | cut -d ':' -f 2
$OASIS_NODE_CLI accounts show $ESCROW_ACCOUNT | grep -A 3 "cipher PARATIME" | grep native | cut -d ':' -f 2 | cut -c 1- | rev | cut -c 10- | rev
