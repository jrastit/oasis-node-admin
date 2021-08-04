. oasis_env.sh
cat $LOCAL_DIR/entity/entity.json | awk 'BEGIN { FS = "\"" } ;{print($6)}' 

