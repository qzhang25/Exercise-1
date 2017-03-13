--New table to get hospital general information
DROP TABLE ERdiagram_hospital_gen;
CREATE TABLE ERdiagram_hospital_gen AS
SELECT provider_id, hospital_name, state
FROM gen_info;


--New table to get time_effec care_info
DROP TABLE ERdiagram_effective_time;
CREATE TABLE ERdiagram_effective_time AS
SELECT provider_id, hospital_name, state, condition, score, meas_id
FROM time_info;


--New table to get survev_response_info. And try to calculate the percentage for the next step
DROP TABLE ERdiagram_survey_resp;
CREATE TABLE ERdiagram_survey_resp AS
SELECT provider_id, hospital_name, state, 
SUBSTRING(nurse_achieve, 1, 2)/SUBSTR(nurse_achieve, -2) AS nur_achieve, 
SUBSTRING(nurse_improve, 1, 2)/SUBSTR(nurse_improve, -2) AS nur_improve, 
SUBSTRING(nurse_dimen, 1, 2)/SUBSTR(nurse_dimen, -2) AS nurse_dimession, 
SUBSTRING(doc_achieve, 1, 2)/SUBSTR(doc_achieve, -2) AS doc_achieve, 
SUBSTRING(doc_improve, 1, 2)/SUBSTR(doc_improve, -2) AS doc_improve, 
SUBSTRING(doc_dimen, 1, 2)/SUBSTR(doc_dimen, -2) AS doctor_dimession, 
SUBSTRING(staff_achieve, 1, 2)/SUBSTR(staff_achieve, -2) AS staff_achieve, 
SUBSTRING(staff_improve, 1, 2)/SUBSTR(staff_improve, -2) AS staff_improve, 
SUBSTRING(staff_dimen, 1, 2)/SUBSTR(staff_dimen, -2) AS staff_dimession, 
SUBSTRING(pain_achieve, 1, 2)/SUBSTR(pain_achieve, -2) AS pain_achieve, 
SUBSTRING(pain_improve, 1, 2)/SUBSTR(pain_improve, -2) AS pain_improve, 
SUBSTRING(pain_dimen, 1, 2)/SUBSTR(pain_dimen, -2) AS pain_dimession, 
SUBSTRING(med_achieve, 1, 2)/SUBSTR(med_achieve, -2) AS med_achieve, 
SUBSTRING(med_improve, 1, 2)/SUBSTR(med_improve, -2) AS med_improve, 
SUBSTRING(med_dimen, 1, 2)/SUBSTR(med_dimen, -2) AS med_dimession, 
SUBSTRING(clean_quiet_achieve, 1, 2)/SUBSTR(clean_quiet_achieve, -2) AS clquiet_achieve, 
SUBSTRING(clean_quiet_improve, 1, 2)/SUBSTR(clean_quiet_improve, -2) AS clquiet_improve, 
SUBSTRING(clean_quiet_dimen, 1, 2)/SUBSTR(clean_quiet_dimen, -2) AS clquiet_dimession, 
SUBSTRING(discharge_achieve, 1, 2)/SUBSTR(discharge_achieve, -2) AS disch_achieve, 
SUBSTRING(discharge_improve, 1, 2)/SUBSTR(discharge_improve, -2) AS disch_improve, 
SUBSTRING(discharge_dimen, 1, 2)/SUBSTR(discharge_dimen, -2) AS disch_dimession, 
SUBSTRING(overall_achieve, 1, 2)/SUBSTR(overall_achieve, -2) AS total_achieve, 
SUBSTRING(overall_improve, 1, 2)/SUBSTR(overall_improve, -2) AS total_improve, 
SUBSTRING(overall_dimen, 1, 2)/SUBSTR(overall_dimen, -2) AS total_dimession, hcahps_base_score, hcahps_consist_score
FROM survey_info;
