SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo "entity account oasis..."
read ESCROW_ACCOUNT

echo "stake amount \( x * 10^9 ROSE or TEST\)"
read AMOUNT

NONCE=`$SCRIPT_ENTITY_INFO_DIR/nonce.sh`
TX=add_stake$(date +%s).json
OUTPUT_TX=$LOCAL_TX/$TX

echo nonce: $NONCE

$SCRIPT_DIR/oasis_local.sh stake account gen_escrow \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.amount $AMOUNT \
	--stake.escrow.account $ESCROW_ACCOUNT \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 2000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

if [ $? -ne 0 ]; then
	echo Error: transaction error
	exit 1
fi 

$SCRIPT_DIR/submit_transaction.sh $TX
