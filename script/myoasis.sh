#/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

STAKE_ADDRESS=`$SCRIPT_DIR/account_info/get_entity_address.sh`

$SCRIPT_DIR/oasis.sh --stake.account.address $STAKE_ADDRESS $@
