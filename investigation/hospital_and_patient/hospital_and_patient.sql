--New table for all the checking categories 
DROP TABLE SURVEYAVG_AA;
CREATE TABLE SURVEYAVG_AA AS
SELECT hospital_name,
AVG(nur_dim) AS nur_dim_avg_score,
AVG(doc_dim) AS doc_dim_avg_score,
AVG(staff_dim) AS staff_dim_avg_score,
AVG(pain_dim) AS pain_dim_avg_score,
AVG(med_dim) AS med_dim_avg_score,
AVG(clquiet_dim) AS clquiet_dim_avg_score,
AVG(disch_dim) AS disch_dim_avg_score,
AVG(total_ac) AS total_ac_avg_score,
AVG(total_imp) AS total_imp_avg_score,
AVG(total_dim) AS tot_dim_avg_score
FROM ERdiagram_survey_resp
GROUP BY hospital_name
ORDER BY tot_dim_avg_score DESC;

--New table to combine  
DROP TABLE COMBINE_HOSPITAL;
CREATE TABLE COMBINE_HOSPITAL AS
SELECT FINAL_TIM.hospital_name, FINAL_TIM.test_avg, SURVEYAVG_AA.nur_dim_avg_score, SURVEYAVG_AA.doc_dim_avg_score, SURVEYAVG_AA.staff_dim_avg_score, SURVEYAVG_AA.pain_dim_avg_score, SURVEYAVG_AA.med_dim_avg_score, SURVEYAVG_AA.clquiet_dim_avg_score, SURVEYAVG_AA.disch_dim_avg_score, SURVEYAVG_AA.total_ac_avg_score, SURVEYAVG_AA.total_imp_avg_score, SURVEYAVG_AA.tot_dim_avg_score
FROM FINAL_TIM
INNER JOIN SURVEYAVG_AA
ON FINAL_TIM.hospital_name = SURVEYAVG_AA.hospital_name
ORDER BY FINAL_TIM.test_avg;


--New table to caculate correlation
create table FINAL_Summary
as
select  inline
(
array
(
struct ('Cor_nur', (Avg(test_avg * nur_dim_avg_score) - Avg(test_avg) * Avg(nur_dim_avg_score)) / (Stddev(test_avg) * Stddev(nur_dim_avg_score))  )
,struct ('Cor_doc', (Avg(test_avg * doc_dim_avg_score) - Avg(test_avg) * Avg(doc_dim_avg_score)) / (Stddev(test_avg) * Stddev(doc_dim_avg_score))  )
,struct ('Cor_staff', (Avg(test_avg * staff_dim_avg_score) - Avg(test_avg) * Avg(staff_dim_avg_score)) / (Stddev(test_avg) * Stddev(staff_dim_avg_score)) )
,struct ('Cor_pain', (Avg(test_avg * pain_dim_avg_score) - Avg(test_avg) * Avg(pain_dim_avg_score)) / (Stddev(test_avg) * Stddev(pain_dim_avg_score))   )
,struct ('Cor_med', (Avg(test_avg * med_dim_avg_score) - Avg(test_avg) * Avg(med_dim_avg_score)) / (Stddev(test_avg) * Stddev(med_dim_avg_score))   )
,struct ('Cor_clquiet', (Avg(test_avg * clquiet_dim_avg_score) - Avg(test_avg) * Avg(clquiet_dim_avg_score)) / (Stddev(test_avg) * Stddev(clquiet_dim_avg_score)) )
,struct ('Cor_disch', (Avg(test_avg * disch_dim_avg_score) - Avg(test_avg) * Avg(disch_dim_avg_score)) / (Stddev(test_avg) * Stddev(disch_dim_avg_score)) )
,struct ('Cor_tot_ach', (Avg(test_avg * total_ac_avg_score) - Avg(test_avg) * Avg(total_ac_avg_score)) / (Stddev(test_avg) * Stddev(total_ac_avg_score)) )
,struct ('Cor_tot_imp', (Avg(test_avg * total_imp_avg_score) - Avg(test_avg) * Avg(total_imp_avg_score)) / (Stddev(test_avg) * Stddev(total_imp_avg_score)) )
,struct ('Cor_tot_dim', (Avg(test_avg * tot_dim_avg_score) - Avg(test_avg) * Avg(tot_dim_avg_score)) / (Stddev(test_avg) * Stddev(tot_dim_avg_score)) )
)
) as (Surv_Resp,Correlation)
from    COMBINE_HOSPITAL;

SELECT * FROM FINAL_Summary;
