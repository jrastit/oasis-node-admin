export NONCE=`./nonce.sh`
export AMOUNT=`./stakeShare.sh`
export ENTITY_DIR=/home/oasis/mainnet/entity/
export GENESIS_JSON=/home/oasis/mainnet/genesis.json
export OUTPUT_TX=/home/oasis/script/unstake.json

if [ -z "$AMOUNT" ]
then
	echo "amount is empty"
	exit 0
fi

oasis-node stake account gen_reclaim_escrow \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.shares $AMOUNT \
	--stake.escrow.account oasis1qz26ty8q6gwt6zah7dtt8jpepvwnttkg8ssnxjl7 \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1500 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE
echo copy file $OUTPUT_TX
scp -4 $OUTPUT_TX oasis@aitvt.com:$OUTPUT_TX
echo send transaction $OUTPUT_TX
oasis.sh consensus submit_tx --transaction.file $OUTPUT_TX

