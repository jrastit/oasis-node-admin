export NONCE=`./nonce.sh`
export TX=transfer.json
export OUTPUT_TX=$LOCAL_TX/$TX
export AVAILABLE=`./stakeAvailable.sh`
export AMOUNT=`expr $AVAILABLE - 100000000000`

if [ -z "$AMOUNT" ]
then
	echo "amount is empty"
	exit 0
fi

./oasis_local.sh stake account gen_transfer \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.amount $AMOUNT \
	--stake.transfer.destination oasis1qzdtr27nstkwr27c5pp9r84gewc0nlg8lvhchnmx \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1500 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE 

./submit_transaction.sh $TX
