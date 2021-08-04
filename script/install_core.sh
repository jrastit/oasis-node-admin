. oasis_env.sh

cd $LOCAL_DIR
mkdir -p oasis-core
cd oasis-core
wget -O $OASIS_CORE_TAR  $OASIS_CORE_URL
tar -xf $OASIS_CORE_TAR
rm -f $OASIS_CORE_TAR

