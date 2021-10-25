SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

NONCE=`$SCRIPT_ACCOUNT_INFO_DIR/nonce.sh`
TX=unstake$(date +%s).json
OUTPUT_TX=$LOCAL_TX/$TX

AMOUNT=`$SCRIPT_ACCOUNT_INFO_DIR/get_stake_share.sh`
ESCROW_ACCOUNT=`$SCRIPT_ACCOUNT_INFO_DIR/get_entity_address.sh`


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

$SCRIPT_DIR/submit_transaction.sh $TX

