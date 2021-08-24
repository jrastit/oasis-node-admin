. oasis_env.sh

NODE_JSON_LIST=`find -L $ENTITY_DIR/node -name node_genesis.json | xargs -d ","`
echo json list : $NODE_JSON_LIST

export NONCE=`./nonce.sh`
export TX=update_entity.json
export OUTPUT_TX=$LOCAL_TX/$TX

./oasis_local.sh registry entity update \
	--signer.dir $ENTITY_DIR  \
	--entity.node.descriptor $NODE_JSON_LIST

./oasis_local.sh registry entity gen_register \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 7000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

./submit_transaction.sh $TX
