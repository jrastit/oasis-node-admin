#/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

all=($OASIS_NODE_TYPE)
for NODE_TYPE in "${all[@]}"; do
	. $SCRIPT_DIR/chain_info/network_parameter.sh

	echo core $NETWORK_PARAMETER_CORE_VERSION
	echo genesis $NETWORK_PARAMETER_GENESIS
	echo seed $NETWORK_PARAMETER_SEED

	echo paratime $NETWORK_PARAMETER_PARATIME_CORE_VERSION $NETWORK_PARAMETER_PARATIME_VERSION
	echo paratime ID $NETWORK_PARAMETER_RUNTIME_IDENTIFIER
	echo IAS $NETWORK_PARAMETER_IAS
done
