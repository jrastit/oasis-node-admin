#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [[ -z $OASIS_NODE_ENTITY ]]
then
	echo "entity name (my_entity)?"
	read OASIS_NODE_ENTITY
fi

if [[ -z $OASIS_NODE_ENTITY ]]
then
	OASIS_NODE_ENTITY=my_entity
fi

ENTITY_DIR=$CONFIG_ENTITY_DIR/$OASIS_NODE_ENTITY

if [[ -d "$ENTITY_DIR" ]]
then
    echo "$ENTITY_DIR exists on your filesystem. Abroting"
    exit 1
fi

mkdir -m700 -p $ENTITY_DIR
cd $ENTITY_DIR
$LOCAL_BIN registry entity init
echo entity created $ENTITY_DIR

