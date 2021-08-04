. ./oasis_env.sh

echo copy file $LOCAL_TX/$1 to $NETWORK_HOST
if [ -n "$NETWORK_HOST" ]; then 
	ssh -4 $NETWORK_HOST mkdir -p $NETWORK_TX
	scp -4 $LOCAL_TX/$1 $NETWORK_HOST:$NETWORK_TX/$1
	echo send transaction $1
	./oasis.sh consensus submit_tx --transaction.file $NETWORK_TX/$1
else 
	./oasis.sh consensus submit_tx --transaction.file $LOCAL_TX/$1
fi

