. oasis_env.sh

echo Amount in ROSE * 10^9
read AMOUNT

echo address \( oasis... \)
read ADDRESS

export NONCE=`./nonce.sh`
export TX=transfer.json
export OUTPUT_TX=$LOCAL_TX/$TX

./oasis_local.sh stake account gen_transfer \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.amount $AMOUNT \
	--stake.transfer.destination ADDRESS \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1500 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

./submit_transaction.sh $TX

