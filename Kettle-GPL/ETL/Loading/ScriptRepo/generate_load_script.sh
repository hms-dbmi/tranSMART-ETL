## Generate Study
STUDY=''



## Adming Configs
LOADING_DIR=$KETTLE_LOADING_DIR

mkdir -p ${LOADING_DIR}/'Registries'/${STUDY}/{'data'/{'datafiles','raw_datafiles'},'logs'}
cp "ScriptRepo/Load_Study.sh" "${LOADING_DIR}/${STUDY}_Load.sh"
cp "ScriptRepo/resolve_db_issues.sh" "${LOADING_DIR}/${STUDY}_resolve_db_issues.sh"
