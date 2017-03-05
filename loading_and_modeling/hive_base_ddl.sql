--DDL SQL for hosp gen info
DROP TABLE gen_info;
CREATE EXTERNAL TABLE gen_info
(provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
hospital_type string,
hospital_own string,
emer_services boolean)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/qinghos_gen';


-- DDL SQL for the time_effec 
DROP TABLE time_info;
CREATE EXTERNAL TABLE time_info
(provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
condition string,
meas_id string,
meas_name string,
score int,
sample int,
footnote string,
meas_start date,
meas_end date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/t_eff';

-- DDL SQL statement for meas_dates 
DROP TABLE dates_info;
CREATE EXTERNAL TABLE dates_info
(meas_name string,
meas_id string,
meas_st_qrt string,
meas_start date,
meas_end_qrt string,
meas_end date)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/dates';


--DDL SQL for the surv_resp 
DROP TABLE survey_info;
CREATE EXTERNAL TABLE survey_info
(provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
nurse_achieve int,
nurse_improve int,
nurse_dimen int,
doc_achieve int,
doc_improve int,
doc_dimen int,
staff_achieve int,
staff_improve int,
staff_dimen int,
pain_achieve int,
pain_improve int,
pain_dimen int,
med_achieve int,
med_improve int,
med_dimen int,
clean_quiet_achieve int,
clean_quiet_improve int,
clean_quiet_dimen int,
discharge_achieve int,
discharge_improve int,
discharge_dimen int,
overall_achieve int,
overall_improve int,
overall_dimen int,
hcahps_base_score int,
hcahps_consist_score int)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ( "separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/su_res';
