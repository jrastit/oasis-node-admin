. oasis_env.sh
ENTITY_ID=`./get_entity_id.sh`
./oasis_local.sh stake pubkey2address --public_key $ENTITY_ID
