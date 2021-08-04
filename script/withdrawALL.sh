export NONCE=`./nonce.sh`
export TX=transfer.json
export OUTPUT_TX=$LOCAL_TX/$TX
export AVAILABLE=`./stakeAvailable.sh`
#keep 100 ROSE 
export AMOUNT=`expr $AVAILABLE - 100000000000`

if [ -z "$AMOUNT" ]
then
	echo "amount is empty"
	exit 0
fi

echo destination address \( oasis... \)
read TO_ADDRESS

./oasis_local.sh stake account gen_transfer \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.amount $AMOUNT \
	--stake.transfer.destination $TO_ADDRESS \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1500 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE 

./submit_transaction.sh $TX
