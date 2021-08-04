export NONCE=`./nonce.sh`
export ENTITY_DIR=/home/oasis/mainnet/entity/
export GENESIS_JSON=/home/oasis/mainnet/genesis.json
export OUTPUT_TX=/home/oasis/script/transfer.json
export AVAILABLE=`./stakeAvailable.sh`
export AMOUNT=`expr $AVAILABLE - 100000000000`

if [ -z "$AMOUNT" ]
then
	echo "amount is empty"
	exit 0
fi

oasis-node stake account gen_transfer \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.amount $AMOUNT \
	--stake.transfer.destination oasis1qzdtr27nstkwr27c5pp9r84gewc0nlg8lvhchnmx \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1500 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE 

echo copy file $OUTPUT_TX
scp -4 $OUTPUT_TX oasis@aitvt.com:$OUTPUT_TX
echo send transaction $OUTPUT_TX
oasis.sh consensus submit_tx --transaction.file $OUTPUT_TX
