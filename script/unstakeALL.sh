. oasis_env.sh

export NONCE=`./nonce.sh`
export TX=unstake.json
export OUTPUT_TX=$LOCAL_TX/$TX

export AMOUNT=`./stakeShare.sh`

if [ -z "$AMOUNT" ]
then
	echo "amount is empty"
	exit 0
fi

./oasis_local.sh stake account gen_reclaim_escrow \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.shares $AMOUNT \
	--stake.escrow.account $STAKE_ACCOUNT \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1500 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

./submit_transaction.sh $TX

