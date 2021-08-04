#!/bin/bash

. ./oasis_env.sh

echo $NETWORK_BIN -a $NETWORK_ADDR $@ >&2
$NETWORK_BIN -a $NETWORK_ADDR $@

