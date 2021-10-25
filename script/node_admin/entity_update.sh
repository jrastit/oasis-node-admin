#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

NODE_JSON_LIST=`find -L $ENTITY_DIR/node -name node_genesis.json | awk '{r=r s $1;s=","} END{print r}'`
echo json list : $NODE_JSON_LIST

NONCE=`$SCRIPT_ACCOUNT_INFO_DIR/nonce.sh`
TX=update_entity$(date +%s).json
OUTPUT_TX=$LOCAL_TX/$TX

$SCRIPT_DIR/oasis_local.sh registry entity update \
	--signer.dir $ENTITY_DIR  \
	--entity.node.descriptor $NODE_JSON_LIST

$SCRIPT_DIR/oasis_local.sh registry entity gen_register \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 7000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

$SCRIPT_DIR/submit_transaction.sh $TX
