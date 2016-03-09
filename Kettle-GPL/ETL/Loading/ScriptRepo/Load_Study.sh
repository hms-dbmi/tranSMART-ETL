#!/bin/bash

MAPPING_FILE=''
RAW_MAPPING=''
STUDY_ID=''
TOP_NODE=''
FACT_SET=''
LOAD_REGISTRY=''
LOAD_RAW=''


















## ADMIN Variables do not change unless specified
## '/scratchg/data/NAMHR4/data/datafiles/'
ENVIRONMENT=$GRDR_DEVELOPMENT
DATA_LOCATION='/scratch/ETL/Loading/Registries/'$STUDY_ID'/data/datafiles'
RAW_DATA='/scratch/ETL/Loading/Registries/'$STUDY_ID'/data/raw_datafiles'

LOGFILE='''logs/'$STUDY_ID'.log'''
DEBUG='Basic'
LOAD_TYPE='I'
SORT_DIR='/scratch/'

## DO NOT CHANGE ANYTHING BELOW!!!!!
export KETTLE_HOME=$ENVIRONMENT

## Validation


## Load Study's Mapped data and GRDR Concepts
if [ $LOAD_REGISTRY == 'Y' ];
        then 
	echo "Here"
	./ScriptRepo/create_clinical_data.sh ${MAPPING_FILE} '"'${STUDY_ID}'"' '"'${SORT_DIR}'"' '"'${FACT_SET}'"' ${DATA_LOCATION} '"'${RAW_DATA}'"' '"'${LOGFILE}'"' '"'${DEBUG}'"' ${LOAD_TYPE} "${TOP_NODE}" >> "${LOGFILE}" 2>>"${LOGFILE}_ERROR.log"
fi

 MAPPING_FILE=$RAW_MAPPING

## Load Study's Raw Data
if [ $LOAD_RAW == 'Y' ];
        ./ScriptRepo/create_clinical_data.sh ${MAPPING_FILE} '"'${STUDY_ID}'"' '"'${SORT_DIR}'"' '"'${FACT_SET}'"' ${DATA_LOCATION} '"'${RAW_DATA}'"' '"'${LOGFILE}'"' '"'${DEBUG}'"' ${LOAD_TYPE} "${TOP_NODE}" >> "${LOGFILE}" 2>>"${LOGFILE}_ERROR.log"
fi
     
