#/bin/bash

case $OASIS_NODE_NETWORK in
	mainnet)
		echo "Mainnet"
		NETWORK_PARAMETER=`wget -O - https://raw.githubusercontent.com/oasisprotocol/docs/main/docs/node/mainnet/README.md 2>/dev/null` 
	;;
	testnet)
		echo "Testnet"
		NETWORK_PARAMETER=`wget -O - https://raw.githubusercontent.com/oasisprotocol/docs/main/docs/node/testnet/README.md 2>/dev/null` 
	;;
	*)	
		echo "config error type : $OASIS_NODE_NETWORK not found"
		exit 1
	;;
esac

OASIS_CORE_URL_ROOT="https://github.com/oasisprotocol/oasis-core/releases/tag/v"

NETWORK_PARAMETER_CORE_VERSION=`echo -e "$NETWORK_PARAMETER" | grep $OASIS_CORE_URL_ROOT | head -n 1 | awk -F "$OASIS_CORE_URL_ROOT|)" '{print $2}'`
NETWORK_PARAMETER_GENESIS=`echo -e "$NETWORK_PARAMETER" | grep "genesis\.json" | awk -F "\\\\\\\\(|)" '{print $2}'`
NETWORK_PARAMETER_SEED=`echo -e "$NETWORK_PARAMETER" | grep "Oasis seed node address" -A 1 | tail -n 1 | awk -F "\\\`" '{print $2}'`

case $NODE_TYPE in
	validator)
		echo "config validator"
	;;
	nonvalidator)
		echo "config nonvalidator"
	;;
	emerald)
		echo "config emerald"
		PARATIME_INDEX_IN_DOC=4
		PARATIME_URL_ROOT="https://github.com/oasisprotocol/emerald-paratime/releases/tag/v" 
	;;
	cipher)
		echo "config cipher"
		PARATIME_INDEX_IN_DOC=3
		PARATIME_URL_ROOT="https://github.com/oasisprotocol/cipher-paratime/releases/tag/v" 
		NETWORK_PARAMETER_IAS=`echo -e "$NETWORK_PARAMETER" | grep "IAS proxy address" -A 1 | tail -n 1 | awk -F "\\\`" '{print $2}'`
	;;
	sapphire)
		echo "config sapphire"
		PARATIME_INDEX_IN_DOC=2
		PARATIME_URL_ROOT="https://github.com/oasisprotocol/sapphire-paratime/releases/tag/v" 
		NETWORK_PARAMETER_IAS=`echo -e "$NETWORK_PARAMETER" | grep "IAS proxy address" -A 1 | tail -n 1 | awk -F "\\\`" '{print $2}'`
	;;
	*)
		echo "chain info2: config error type : $NODE_TYPE not found"
	;;
esac
if [[ -n "$PARATIME_INDEX_IN_DOC" ]]; then
	NETWORK_PARAMETER_PARATIME_CORE_VERSION=`echo -e "$NETWORK_PARAMETER" | grep $OASIS_CORE_URL_ROOT | head -n "$PARATIME_INDEX_IN_DOC" | tail -n 1 | awk -F "$OASIS_CORE_URL_ROOT|)" '{print $2}'`
	NETWORK_PARAMETER_RUNTIME_IDENTIFIER=`echo -e "$NETWORK_PARAMETER" | grep "Runtime identifier" -A 1 | grep '\`' | head -n "$(expr $PARATIME_INDEX_IN_DOC - 1)" | tail -n 1 | awk -F "\\\`" '{print $2}'`
fi
if [[ -n "$PARATIME_URL_ROOT" ]]; then
	NETWORK_PARAMETER_PARATIME_VERSION=`echo -e "$NETWORK_PARAMETER" | grep $PARATIME_URL_ROOT | sort | tail -n 1 | awk -F "$PARATIME_URL_ROOT|)" '{print $2}'`
fi

