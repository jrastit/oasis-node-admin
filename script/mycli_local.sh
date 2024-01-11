#/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

STAKE_ADDRESS=`$SCRIPT_ENTITY_INFO_DIR/get_entity_address.sh`

$SCRIPT_DIR/cli_local.sh $@ $STAKE_ADDRESS  --show-delegations
