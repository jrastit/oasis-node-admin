. oasis_env.sh
cd $LOCAL_DIR
if [[ -d "$LOCAL_DIR/entity" ]]
then
    echo "$LOCAL_DIR/entity exists on your filesystem. Abroting"
    exit 1
fi

mkdir -m700 -p entity
cd entity
$LOCAL_BIN registry entity init

