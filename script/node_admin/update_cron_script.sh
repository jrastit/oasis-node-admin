#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

STAKE_ADDRESS=`$SCRIPT_ENTITY_INFO_DIR/get_entity_address.sh`
$REMOTE_CMD mkdir -p $OASIS_NODE_DIR/cron/script
$REMOTE_CMD mkdir -p $OASIS_NODE_DIR/cron/update_balance

$REMOTE_CMD "cat > $OASIS_NODE_DIR/cron/script/update_balance.sh <<- EOF
$OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-node -a $OASIS_NODE_SOCK --stake.account.address $STAKE_ADDRESS stake account info 2>&1 > $OASIS_NODE_DIR/cron/update_balance/\\\`date +%s\\\`_result.txt
EOF
"
$REMOTE_CMD "chmod +x $OASIS_NODE_DIR/cron/script/update_balance.sh"
echo "0 0 * * * bash -c $OASIS_NODE_DIR/cron/script/update_balance.sh 2>&1 1>/dev/null"
