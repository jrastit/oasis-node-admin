#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo update rate \(epoc/percent * 1000\)
read SCHEDULE_RATES

NONCE=`$SCRIPT_ACCOUNT_INFO_DIR/nonce.sh`
TX=update_rate$(date +%s).json
OUTPUT_TX=$LOCAL_TX/$TX

$SCRIPT_DIR/oasis_local.sh stake account gen_amend_commission_schedule \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--stake.commission_schedule.rates $SCHEDULE_RATES \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 1000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

$SCRIPT_DIR/submit_transaction.sh $TX
