echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "$2 Registry Loading - $0"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

echo "'""${10}""'"


/opt/etl/src/data-integration/kitchen.sh \
-norep=Y \
-file=/opt/etl/src/tranSMART-ETL/Kettle-GPL/Kettle-ETL/create_clinical_data.kjb \
-level=Basic \
-param:COLUMN_MAP_FILE=$1 \
-param:DATA_LOCATION=$5 \
-param:STUDY_ID=$2 \
-param:TOP_NODE="${10}" \
-param:SORT_DIR='/scratch/ETL' \
-param:LOAD_TYPE=$9 \
-param:LOADER_PATH=/scratchg/tmp/11.2.0/client_2/bin/sqlldr \
-param:FACT_SET=$4

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "$2 Registry Load Completed - $0"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
