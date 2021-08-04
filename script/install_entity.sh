. oasis_env.sh
if [[ -d "$ENTITY_DIR/entity" ]]
then
    echo "$ENTITY_DIR/entity exists on your filesystem. Abroting"
    exit 1
fi

mkdir -m700 -p $ENTITY_DIR
cd $ENTITY_DIR
$LOCAL_BIN registry entity init

