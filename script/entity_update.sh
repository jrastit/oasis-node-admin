. oasis_env.sh

echo node ids
read NODE_IDS \(id1,id2\)

NODE_JSON_LIST=`find $ENTITY_DIR/node_genesis.json | xargs -d ","`
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
