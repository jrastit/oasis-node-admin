#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

ENTITY_LIST=`$SCRIPT_DIR/oasis.sh registry entity list`

for ENTITY_ID in $ENTITY_LIST; do
	ENTITY_ADDRESS=`$LOCAL_BIN stake pubkey2address --public_key $ENTITY_ID`
	PARATIME_BALANCE=`$OASIS_NODE_CLI accounts show $ENTITY_ADDRESS | grep -A 3 "cipher PARATIME" | grep native | cut -d ':' -f 2 | cut -c 1- | rev | cut -c 10- | rev`
	if [ -n "$PARATIME_BALANCE" ]; then	
		#echo "id : $ENTITY_ID"
		#echo "address : $ENTITY_ADDRESS"
		#echo "balance : $PARATIME_BALANCE"
		echo $ENTITY_ADDRESS : $PARATIME_BALANCE
	fi
done
