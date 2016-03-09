#!/bin/bash

MAPPING_FILE=''
RAW_MAPPING=''
STUDY_ID=''
TOP_NODE=''
FACT_SET=''
LOAD_REGISTRY='Y'
LOAD_RAW='N'

ENVIRONMENT=$KETTLE_DEVELOPMENT

















## ADMIN Variables do not change unless specified
## '/scratchg/data/NAMHR4/data/datafiles/'
DATA_LOCATION=$KETTLE_LOADING_DIR'Registries/'$STUDY_ID'/data/datafiles'
RAW_DATA=$KETTLE_LOADING_DIR'/Registries/'$STUDY_ID'/data/raw_datafiles'

LOGFILE=$KETTLE_LOADING_DIR'logs/'$STUDY_ID'.log'
DEBUG='Basic'
LOAD_TYPE='I'
SORT_DIR=$KETTLE_LOADING_DIR

## DO NOT CHANGE ANYTHING BELOW!!!!!
export KETTLE_HOME=$ENVIRONMENT

## Validation


## Load Study's Mapped data and GRDR Concepts
if [ $LOAD_REGISTRY == 'Y' ];
        then
        ./ScriptRepo/create_clinical_data.sh ${MAPPING_FILE} ${STUDY_ID} "'"${SORT_DIR}"'" ${FACT_SET} ${DATA_LOCATION} ${RAW_DATA} ${LOGFILE} ${DEBUG} ${LOAD_TYPE} "${TOP_NODE}" >> "${LOGFILE}" 2>>"${LOGFILE}_ERROR.log"
fi

 MAPPING_FILE=$RAW_MAPPING
 DATA_LOCATION=$RAW_DATA
## Load Study's Raw Data
if [ $LOAD_RAW == 'Y' ];
        then
        ./ScriptRepo/create_clinical_data.sh ${MAPPING_FILE} ${STUDY_ID} "'"${SORT_DIR}"'" ${FACT_SET} ${DATA_LOCATION} ${RAW_DATA} ${LOGFILE} ${DEBUG} ${LOAD_TYPE} "${TOP_NODE}/__RAW" >> "${LOGFILE}" 2>>"${LOGFILE}_ERROR.log"
fi

     
