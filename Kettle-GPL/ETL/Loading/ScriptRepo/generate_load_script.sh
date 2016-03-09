## Generate Study
STUDY='TEST2'

## Adming Configs
LOADING_DIR='/scratch/ETL/Loading'

mkdir -p ${LOADING_DIR}/'Registries'/${STUDY}/{'data'/{'datafiles','raw_datafiles'},'logs'}
cp "${LOADING_DIR}/ScriptRepo/Load_Study.sh" "${LOADING_DIR}/${STUDY}_Load.sh"
cp "${LOADING_DIR}/ScriptRepo/resolve_db_issues.sh" "${LOADING_DIR}/${STUDY}_resolve_db_issues.sh"
