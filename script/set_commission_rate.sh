. oasis_env.sh

echo update rate \(epoc/percent * 1000\)
read SCHEDULE_RATES

export NONCE=`./nonce.sh`
export TX=update_rate.json
export OUTPUT_TX=$LOCAL_TX/$TX

./oasis_local.sh stake account gen_amend_commission_schedule \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.commission_schedule.rates $SCHEDULE_RATES \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

./submit_transaction $TX
