--Building a descending average score table “Emergency Department”. 
DROP TABLE Emergency_AVG;
CREATE TABLE Emergency_AVG AS
SELECT hospital_name, AVG(score) AS emr_avg_score FROM ERdiagram_effective_time WHERE condition = 'Emergency Department'
GROUP BY hospital_name
ORDER BY emr_avg_score DESC;

--Building a descending average score table for “Surgical Care Improvement”.
DROP TABLE Surgicalcare_AVG;
CREATE TABLE Surgicalcare_AVG AS
SELECT hospital_name, AVG(score) AS sci_avg_score FROM ERdiagram_effective_time WHERE condition = 'Surgical Care Improvement Project'
GROUP BY hospital_name
ORDER BY sci_avg_score DESC;

--Building a descending average score table for “Children’s Asthma”. 
DROP TABLE childrenasthma_AVG;
CREATE TABLE childrenasthma_AVG AS
SELECT hospital_name, AVG(score) AS asth_avg_score FROM ERdiagram_effective_time WHERE meas_id = 'CAC_3'
GROUP BY hospital_name
ORDER BY asth_avg_score DESC;

--Building a descending average score for “Heart Failure”.
DROP TABLE Heartfailure_AVG;
CREATE TABLE Heartfailure_AVG AS
SELECT hospital_name, AVG(score) AS hf_avg_score FROM ERdiagram_effective_time WHERE condition = 'Heart Failure'
GROUP BY hospital_name
ORDER BY hf_avg_score DESC;

--Building a descending average score table for “Stroke Care” .
DROP TABLE StrokeC_AVG;
CREATE TABLE StrokeC_AVG AS
SELECT hospital_name, AVG(score) AS sc_avg_score FROM ERdiagram_effective_time WHERE condition = 'Stroke Care'
GROUP BY hospital_name
ORDER BY sc_avg_score DESC;

--Combining Emergency Department with Surgical Care Improvement score on average by hospital.
DROP TABLE COMBINE1;
CREATE TABLE COMBINE1 AS
SELECT Emergency_AVG.hospital_name, Emergency_AVG.emr_avg_score, Surgicalcare_AVG.sci_avg_score
FROM Emergency_AVG
INNER JOIN Surgicalcare_AVG
ON Emergency_AVG.hospital_name = Surgicalcare_AVG.hospital_name;

--Combining JOIN1 with Children’s Asthma score on average by hospital.
DROP TABLE COMEBINE2;
CREATE TABLE COMEBINE2 AS
SELECT childrenasthma_AVG.hospital_name, childrenasthma_AVG.asth_avg_score, COMBINE1.emr_avg_score, COMBINE1.sci_avg_score
FROM childrenasthma_AVG
INNER JOIN COMBINE1
ON COMBINE1.hospital_name = childrenasthma_AVG.hospital_name;

--Combing JOIN2 with Heart Failure scores by hospital.
DROP TABLE COMBINE3;
CREATE TABLE COMBINE3 AS
SELECT Heartfailure_AVG.hospital_name, Heartfailure_AVG.hf_avg_score, COMEBINE2.emr_avg_score, COMEBINE2.sci_avg_score, COMEBINE2.asth_avg_score
FROM Heartfailure_AVG
INNER JOIN COMEBINE2
ON COMEBINE2.hospital_name = Heartfailure_AVG.hospital_name;

--Combining JOIN3 with Stroke Care score on average by hospital.
DROP TABLE COMBINE4;
CREATE TABLE COMBINE4 AS
SELECT StrokeC_AVG.hospital_name, StrokeC_AVG.sc_avg_score, COMBINE3.emr_avg_score, COMBINE3.sci_avg_score, COMBINE3.asth_avg_score, COMBINE3.hf_avg_score
FROM StrokeC_AVG
INNER JOIN COMBINE3
ON COMBINE3.hospital_name = StrokeC_AVG.hospital_name;


--New rank table for JOIN9 for first five columns.
DROP TABLE First4_RANK;
CREATE TABLE First4_RANK AS
SELECT hospital_name,
RANK() OVER (ORDER BY emr_avg_score DESC) AS emr_rank,
RANK() OVER (ORDER BY sci_avg_score DESC) AS sci_rank,
RANK() OVER (ORDER BY asth_avg_score DESC) AS asth_rank,
RANK() OVER (ORDER BY hf_avg_score DESC) AS hf_rank,
RANK() OVER (ORDER BY sc_avg_score DESC) AS sc_rank
FROM COMBINE4;

--Ranking the categories scores. 
DROP TABLE FINAL_TIM;
CREATE TABLE FINAL_TIM AS
SELECT hospital_name, emr_rank, sci_rank, asth_rank, hf_rank,
(emr_rank + sci_rank + asth_rank + hf_rank)/4 AS test_avg
FROM First4_RANK
ORDER BY test_avg ASC;

--Print top 10 result 
SELECT * FROM FINAL_TIM LIMIT 10;
