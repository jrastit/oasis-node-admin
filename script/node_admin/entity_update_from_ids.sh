#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

#echo node ids
#read NODE_IDS \(id1,id2\)


NODE_IDS=`find -L $ENTITY_DIR/node -name identity_pub.pem -exec awk "NR==2" {} \; | awk '{r=r s $1;s=","} END{print r}'`

echo Node id = $NODE_IDS

NONCE=`$SCRIPT_ACCOUNT_INFO_DIR/nonce.sh`
TX=update_entity.json
OUTPUT_TX=$LOCAL_TX/$TX

$SCRIPT_DIR/oasis_local.sh registry entity update \
	--signer.dir $ENTITY_DIR  \
	--entity.node.id $NODE_IDS

$SCRIPT_DIR/oasis_local.sh registry entity gen_register \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 7000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

$SCRIPT_DIR/submit_transaction.sh $TX
