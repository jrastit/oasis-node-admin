. oasis_env.sh

echo "proposal id" 
read PROPOSAL_ID

export NONCE=`./nonce.sh`
export TX=proposal.json
export OUTPUT_TX=$LOCAL_TX/$TX

./oasis_local.sh governance gen_cast_vote gen_amend_commission_schedule \
	--genesis.file $GENESIS_JSON \
	--signer.backend file \
	--signer.dir $ENTITY_DIR \
	--vote.proposal.id $PROPOSAL_ID \
	--vote yes \
	--transaction.file $OUTPUT_TX \
	--transaction.fee.gas 2000 \
	--transaction.fee.amount 0 \
	--transaction.nonce $NONCE

./submit_transaction.sh $TX
