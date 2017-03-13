--Caculate the Average Score for Survey Response Data 
DROP TABLE SURVEYAVG_AA;
CREATE TABLE SURVEYAVG_AA AS
SELECT hospital_name,
AVG(nurse_dimession) AS nur_dimession_score,
AVG(doc_dim) AS doc_dimession_score,
AVG(staff_dim) AS staff_dimession_score,
AVG(pain_dim) AS pain_dimession_score,
AVG(med_dim) AS med_dimession_score,
AVG(clquiet_dim) AS clquiet_dimession_score,
AVG(disch_dim) AS disch_dimession_score,
AVG(total_ac) AS total_achievement_score,
AVG(total_imp) AS total_improvement_score,
AVG(total_dim) AS total_dimession_score
FROM ERdiagram_survey_resp
GROUP BY hospital_name
ORDER BY total_dimession_score DESC;

--Combine the previous table with the Hospital Average table for the question 1  
DROP TABLE COMBINE_HOSPITAL;
CREATE TABLE COMBINE_HOSPITAL AS
SELECT FINAL_TIM.hospital_name, FINAL_TIM.final_avg, SURVEYAVG_AA.nur_dimession_score, SURVEYAVG_AA.doc_dimession_score, SURVEYAVG_AA.staff_dimession_score, SURVEYAVG_AA.pain_dimession_score, SURVEYAVG_AA.med_dimession_score, SURVEYAVG_AA.clquiet_dimession_score, SURVEYAVG_AA.disch_dimession_score, SURVEYAVG_AA.total_achievement_score, SURVEYAVG_AA.total_improvement_score, SURVEYAVG_AA.total_dimession_score
FROM FINAL_TIM
INNER JOIN SURVEYAVG_AA
ON FINAL_TIM.hospital_name = SURVEYAVG_AA.hospital_name
ORDER BY FINAL_TIM.final_avg DESC;


--Correlation
DROP TABLE FINAL_Summary;
CREATE TABLE FINAL_Summary
as
select  inline
(
array
(
struct ('Correlation_nurse', ( Avg(final_avg * nur_dimession_score) - Avg(final_avg) * Avg(nur_dimession_score)) / (Stddev(final_avg) * Stddev(nur_dimession_score))  )
,struct ('Correlation_doctor', (Avg(final_avg * doc_dimession_score) - Avg(final_avg) * Avg(doc_dimession_score)) / (Stddev(final_avg) * Stddev(doc_dimession_score))  )
,struct ('Correlation_staff', (Avg(final_avg * staff_dimession_score) - Avg(final_avg) * Avg(staff_dimession_score)) / (Stddev(final_avg) * Stddev(staff_dimession_score)) )
,struct ('Corrrelation_pain', (Avg(final_avg * pain_dimession_score) - Avg(final_avg) * Avg(pain_dimession_score)) / (Stddev(final_avg) * Stddev(pain_dimession_score))   )
,struct ('Correlation_medicen', (Avg(final_avg * med_dimession_score) - Avg(final_avg) * Avg(med_dimession_score)) / (Stddev(final_avg) * Stddev(med_dimession_score))   )
,struct ('Correlation_clquiet', (Avg(final_avg * clquiet_dimession_score) - Avg(final_avg) * Avg(clquiet_dimession_score)) / (Stddev(final_avg) * Stddev(clquiet_dimession_score)) )
,struct ('Correlation_discharge', (Avg(final_avg * disch_dimession_score) - Avg(final_avg) * Avg(disch_dimession_score)) / (Stddev(final_avg) * Stddev(disch_dimession_score)) )
,struct ('Correlation_total_achievement', (Avg(final_avg * total_achievement_score) - Avg(final_avg) * Avg(total_achievement_score)) / (Stddev(final_avg) * Stddev(total_achievement_score)) )
,struct ('Correlation_total_improvement', (Avg(final_avg * total_improvement_score) - Avg(final_avg) * Avg(total_improvement_score)) / (Stddev(final_avg) * Stddev(total_improvement_score)) )
,struct ('Correlation_total_dimession', (Avg(final_avg * total_dimession_score) - Avg(final_avg) * Avg(total_dimession_score)) / (Stddev(final_avg) * Stddev(total_dimession_score)) )
)
) as (Surv_Resp,Correlation)
from    COMBINE_HOSPITAL;
--print the correlation result
SELECT * FROM FINAL_Summary;
