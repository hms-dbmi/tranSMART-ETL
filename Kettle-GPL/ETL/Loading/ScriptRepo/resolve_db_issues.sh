# The purpose of this script is to execute a series of cleanup actions that have to be
# performed after the tranSMART database has been loaded with the create_clinical_data.sh 
# script. The first action is to rebuild the indexes. The second action is related to a 
# problem with numerical values. When selecting a patient cohort via a numerical value 
# range (like select all patients older than 50), no statistics are generated when 
# c_columndatatype contains 'N' instead of only 'T'. So this has to be set to 'T'. The 
# third action is cleaning up the database where the value '\\' appears where it should
# not. If this is not done, the tranSMART interface does not show up.
#
# Change everything between **, or simply remove the ** (3 occurrences: lines 17, 58, 63)
#
# On 2015/11/03, the TM_CZ user does not have the right permissions to operate on the
# database. This should be changed as soon as time permits. As long as this is not done,
# use the root user and the root password.

sqlplus <username>/<password>@server:<port>/<instance> << EOF

set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Rebuild the indexes');
end;
/
drop INDEX I2B2METADATA.i2b2_fullname_text;
drop INDEX I2B2DEMODATA.cd_concept_path_text;
GRANT CTXAPP TO i2b2metadata;
GRANT CTXAPP TO i2b2demodata;
CREATE INDEX I2B2METADATA.i2b2_fullname_text ON i2b2metadata.i2b2(c_fullname) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX I2B2DEMODATA.cd_concept_path_text ON i2b2demodata.concept_dimension(concept_path) INDEXTYPE IS CTXSYS.CONTEXT;
REVOKE CTXAPP FROM i2b2metadata;
REVOKE CTXAPP FROM i2b2demodata;
alter INDEX I2B2METADATA.I2B2_IDX1_PART rebuild;
ALTER INDEX I2B2METADATA.I2B2_INDEX1_PART REBUILD;
ALTER INDEX I2B2METADATA.I2B2_INDEX2_PART REBUILD;
ALTER INDEX I2B2METADATA.I2B2_INDEX3_PART REBUILD;
ALTER INDEX I2B2METADATA.I2B2_INDEX4_PART REBUILD;
ALTER INDEX I2B2METADATA.I2B2_C_HLEVEL_BASECODE_PART REBUILD;
ALTER INDEX I2B2METADATA.META_APPLIED_PATH_I2B2_PART REBUILD;
ALTER INDEX I2B2DEMODATA.CONCEPT_COUNTS_INDEX1 REBUILD;
ALTER INDEX I2B2DEMODATA.IDX_OB_FACT_1 REBUILD;
ALTER INDEX I2B2DEMODATA.IDX_OB_FACT_2 REBUILD;
ALTER INDEX I2B2DEMODATA.FACT_MOD_PAT_ENC REBUILD;
ALTER INDEX I2B2DEMODATA.FACT_CNPT_PAT_ENCT_IDX REBUILD;
ALTER INDEX I2B2DEMODATA.PD_IDX_ALLPATIENTDIM REBUILD;
ALTER INDEX I2B2DEMODATA.PATIENT_DIMENSION_INDEX1 REBUILD;
ALTER INDEX I2B2DEMODATA.PATIENT_TRIAL_INDEX1 REBUILD;
ALTER INDEX I2B2DEMODATA.IDX_CONCEPT_DIM3 REBUILD;
ALTER INDEX I2B2DEMODATA.IDX_CONCEPT_DIM_1 REBUILD;
ALTER INDEX I2B2METADATA.I2B2_S_IDX1 REBUILD;
commit;

begin
    DBMS_OUTPUT.put_line('Make sure the numerical values are treated correctly for top node $1');
end;
/ 
update i2b2metadata.i2b2
set c_columndatatype='T'
where c_fullname like '$1%';
commit;

begin
    DBMS_OUTPUT.put_line('Avoid a bug with double slashes');
end;
/
delete from i2b2metadata.i2b2 where c_fullname='\\';
delete from i2b2metadata.i2b2_secure where c_fullname='\\';
delete from I2B2METADATA.TABLE_ACCESS where c_fullname='\\';
commit;

exit;
EOF

