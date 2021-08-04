#/bin/bash

. oasis_env.sh

STAKE_ADDRESS=`./get_entity_address.sh`

./oasis.sh --stake.account.address $STAKE_ADDRESS $@
