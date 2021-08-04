#!/bin/bash

. ./oasis_env.sh

echo $NETWORK_BIN --config $NETWORK_CONFIG 
$NETWORK_BIN --config $NETWORK_CONFIG

