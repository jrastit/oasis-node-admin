SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo "share amount \( x * 10^9 ROSE or TEST\)"
read AMOUNT

NONCE=`$SCRIPT_ENTITY_INFO_DIR/nonce.sh`
TX=unstake$(date +%s).json
OUTPUT_TX=$LOCAL_TX/$TX

ESCROW_ACCOUNT=`$SCRIPT_ENTITY_INFO_DIR/get_entity_address.sh`


if [ -z "$AMOUNT" ]
then
	echo "amount is empty"
	exit 0
fi

$SCRIPT_DIR/oasis_local.sh stake account gen_reclaim_escrow \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.shares $AMOUNT \
	--stake.escrow.account $ESCROW_ACCOUNT \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1500 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

if [ $? -ne 0 ]; then
	echo Error: transaction error
	exit 1
fi 

$SCRIPT_DIR/submit_transaction.sh $TX

