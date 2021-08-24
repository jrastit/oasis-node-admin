#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo "proposal id" 
read PROPOSAL_ID

NONCE=`$SCRIPT_ACCOUNT_INFO_DIR/nonce.sh`
TX=proposal.json
OUTPUT_TX=$LOCAL_TX/$TX

$SCRIPT_DIR/oasis_local.sh governance gen_cast_vote gen_amend_commission_schedule \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--vote.proposal.id $PROPOSAL_ID \
	--vote yes \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 2000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

$SCRIPT_DIR/submit_transaction.sh $TX
