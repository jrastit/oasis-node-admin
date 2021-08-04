. oasis_env.sh
cat $ENTITY_DIR/entity.json | awk 'BEGIN { FS = "\"" } ;{print($6)}' 

