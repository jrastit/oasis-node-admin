. oasis_env.sh

echo "stake amount \( x * 10^9 ROSE or TEST\)"
read AMOUNT

export NONCE=`./nonce.sh`
export TX=gen_escrow.json
export OUTPUT_TX=$LOCAL_TX/$TX

echo nonce: $NONCE

./oasis_local.sh stake account gen_escrow \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.amount $AMOUNT \
	--stake.escrow.account `./get_entity_address.sh` \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 2000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

./submit_transaction.sh $TX
