#! /bin/bash
./data-integration/kitchen.sh \
-norep=Y \
-file=Kettle-ETL/Req2_3_gene_tsv/load_gene_expression_data.kjb \
-log=load_gene_expression_data.log \
-param:DATA_LOCATION=exam \
-param:STUDY_ID=Test009 \
-param:MAP_FILENAME=HD_sample_mapping_file.txt \
-param:DATA_TYPE='R' \
-param:SORT_DIR=/tmp \
-param:DATA_FILE=HD_partial_mrna_data.txt \
-param:TOP_NODE='\Public Studies\ExampleStudy\' \
-param:SAMPLE_MAP_FILENAME=HD_sample_dimensions_mapping.txt \
-param:LOAD_TYPE=I \
-param:DATA_FILE_PREFIX=HD_partial_mrna_data