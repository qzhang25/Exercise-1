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

--Building a descending average score table for “Pneumonia”.
DROP TABLE Pneumonia_AVG;
CREATE TABLE Pneumonia_AVG AS
SELECT hospital_name, AVG(score) AS pneu_avg_score FROM ERdiagram_effective_time WHERE condition = 'Pneumonia'
GROUP BY hospital_name
ORDER BY pneu_avg_score DESC;

--Building a descending table that takes the average scores of each hospital for “Preventive Care” .
DROP TABLE Preventive_AVG;
CREATE TABLE Preventive_AVG AS
SELECT hospital_name, AVG(score) AS prev_avg_score FROM ERdiagram_effective_time WHERE condition = 'Preventive Care'
GROUP BY hospital_name
ORDER BY prev_avg_score DESC;

--Building a descending average score table for “Blood Clot Prevention and Treatment” .
DROP TABLE BloodColt_AVG;
CREATE TABLE BloodColt AS
SELECT hospital_name, AVG(score) AS bc_avg_score FROM ERdiagram_effective_time WHERE condition = 'Blood Clot Prevention and Treatment'
GROUP BY hospital_name
ORDER BY bc_avg_score DESC;

--Building a descending average score table for “Heart Attack or Chest Pain” .
DROP TABLE hearattack_AVG;
CREATE TABLE hearattack_AVG AS
SELECT hospital_name, AVG(score) AS heart_avg_score FROM ERdiagram_effective_time WHERE condition = 'Heart Attack or Chest Pain'
GROUP BY hospital_name
ORDER BY heart_avg_score DESC;

--Building a descending average score table for “Pregnancy and Delivery Care”.
DROP TABLE Pregnancy_AVG;
CREATE TABLE Pregnancy_AVG AS
SELECT hospital_name, AVG(score) AS preg_avg_score FROM ER_time_effec WHERE condition = 'Pregnancy and Delivery Care'
GROUP BY hospital_name
ORDER BY preg_avg_score DESC;

--Combining Emergency Department with Surgical Care Improvement score on average by hospital.
DROP TABLE COMBINE1;
CREATE TABLE COMBINE1 AS
SELECT Emergency_AVG.hospital_name, Emergency_AVG.emr_avg_score, Surgicalcare_AVG.sci_avg_score
FROM Emergency_AVG
INNER JOIN Surgicalcare_AVG
ON Emergency_AVG.hospital_name = Surgicalcare_AVG.hospital_name;

--Combining JOIN1 with Children’s Asthma score on average by hospital.
DROP TABLE COMBINE2;
CREATE TABLE COMEBINE2 AS
SELECT childrenasthma_AVG.hospital_name, childrenasthma_AVG.asth_avg_score, COMBINE1.emr_avg_score, COMBINE1.sci_avg_score
FROM childrenasthma_AVG
INNER JOIN COMBINE1
ON COMBINE1.hospital_name = childrenasthma_AVG.hospital_name;

--Combing JOIN2 with Heart Failure scores by hospital.
DROP TABLE COMBINE3;
CREATE TABLE COMBINE3 AS
SELECT Heartfailure_AVG.hospital_name, Heartfailure_AVG.hf_avg_score, COMBINE2.emr_avg_score, COMBINE2.sci_avg_score, COMBINE2.asth_avg_score
FROM Heartfailure_AVG
INNER JOIN COMBINE2
ON COMBINE2.hospital_name = Heartfailure_AVG.hospital_name;

--Combining JOIN3 with Stroke Care score on average by hospital.
DROP TABLE COMBINE4;
CREATE TABLE COMBINE4 AS
SELECT StrokeC_AVG.hospital_name, StrokeC_AVG.sc_avg_score, COMBINE3.emr_avg_score, COMBINE3.sci_avg_score, COMBINE3.asth_avg_score, COMBINE3.hf_avg_score
FROM StrokeC_AVG
INNER JOIN COMBINE3
ON COMBINE3.hospital_name = StrokeC_AVG.hospital_name;

--Combining JOIN4 with Pneumonia score on average by hospital.
DROP TABLE COMBINE5;
CREATE TABLE COMBINE5 AS
SELECT Pneumonia_AVG.hospital_name, Pneumonia_AVG.pneu_avg_score, COMBINE4.emr_avg_score, COMBINE4.sci_avg_score, COMBINE4.asth_avg_score, COMBINE.hf_avg_score, COMBINE4.sc_avg_score
FROM Pneumonia_AVG
INNER JOIN COMBINE4
ON COMBINE4.hospital_name = Pneumonia_AVG.hospital_name;

--Combing JOIN5 with Preventive score on average by hospital.
DROP TABLE COMBINE6;
CREATE TABLE COMBINE6 AS
SELECT Preventive_AVG.hospital_name, Preventive_AVG.prev_avg_score, COMBINE5.emr_avg_score, COMBINE5.sci_avg_score, COMBINE5.asth_avg_score, COMBINE5.hf_avg_score, COMBINE5.sc_avg_score, COMBINE5.pneu_avg_score
FROM Preventive_AVG
INNER JOIN COMBINE5
ON COMBINE5.hospital_name = Preventive_AVG.hospital_name;

--Combining JOIN6 with Blood Clot Prevention and Treatment on average by hospital.
DROP TABLE COMBINE7;
CREATE TABLE COMBINE7 AS
SELECT BloodColt_AVG.hospital_name, BloodColt_AVG.bc_avg_score, COMBINE6.emr_avg_score, COMBINE6.sci_avg_score, COMBINE6.asth_avg_score, COMBINE6.hf_avg_score, COMBINE6.sc_avg_score, COMBINE6.pneu_avg_score, COMBINE6.prev_avg_score
FROM BloodColt_AVG
INNER JOIN COMBINE6
ON COMBINE6.hospital_name = BloodColt_AVG.hospital_name;

--Combining JOIN7 with Heart Attack or Chest Pain on average by hospital.
DROP TABLE COMBINE8;
CREATE TABLE COMBINE8 AS
SELECT hearattack_AVG.hospital_name, hearattack_AVG.heart_avg_score, COMBINE7.emr_avg_score, COMBINE7.sci_avg_score, COMBINE7.asth_avg_score, COMBINE7.hf_avg_score, COMBINE7.sc_avg_score, COMBINE7.pneu_avg_score, COMBINE7.prev_avg_score, COMBINE7.BC_avg_score
FROM hearattack_AVG
INNER JOIN COMBINE7
ON COMBINE7.hospital_name = hearattack_AVG.hospital_name;

--Combining JOIN8 with Pregnancy and Delivery on average by hospital.
DROP TABLE COMBINE9;
CREATE TABLE COMBINE9 AS
SELECT Pregnancy_AVG.hospital_name, Pregnancy_AVG.preg_avg_score, COMBINE8.emr_avg_score, COMBINE8.sci_avg_score, COMBINE8.asth_avg_score, COMBINE8.hf_avg_score, COMBINE8.sc_avg_score, COMBINE8.pneu_avg_score, COMBINE8.prev_avg_score, COMBINE8.BC_avg_score, COMBINE8.heart_avg_score
FROM Pregnancy_AVG
INNER JOIN COMBINE8
ON COMBINE8.hospital_name = Pregnancy_AVG.hospital_name;

--New rank table for JOIN9 for first five columns.
DROP TABLE First5_RANK;
CREATE TABLE First5_RANK AS
SELECT hospital_name,
RANK() OVER (ORDER BY emr_avg_score DESC) AS emr_rank,
RANK() OVER (ORDER BY sci_avg_score DESC) AS sci_rank,
RANK() OVER (ORDER BY asth_avg_score DESC) AS asth_rank,
RANK() OVER (ORDER BY hf_avg_score DESC) AS hf_rank,
RANK() OVER (ORDER BY sc_avg_score DESC) AS sc_rank
FROM COMBINE9;

-- New rank table for JOIN9 for last five columns.
DROP TABLE Last5_RANK;
CREATE TABLE Last5_RANK AS
SELECT hospital_name,
RANK() OVER (ORDER BY pneu_avg_score DESC) AS pneu_rank,
RANK() OVER (ORDER BY prev_avg_score DESC) AS prev_rank,
RANK() OVER (ORDER BY BC_avg_score DESC) AS BC_rank,
RANK() OVER (ORDER BY heart_avg_score DESC) AS heart_rank,
RANK() OVER (ORDER BY preg_avg_score DESC) AS preg_rank
FROM COMBINE9;

--Building the two tables with the average scores ranked in top 5 and last 5.
DROP TABLE TIME_SUMMARY;
CREATE TABLE TIME_SUMMARY AS
SELECT First5_RANK.hospital_name, First5_RANK.emr_rank, First5_RANK.sci_rank, First5_RANK.asth_rank, First5_RANK.hf_rank, First5_RANK.sc_rank, Last5_RANK.pneu_rank, Last5_RANK.prev_rank, Last5_RANK.BC_rank, Last5_RANK.heart_rank, Last5_RANK.preg_rank
FROM First5_RANK
INNER JOIN Last5_RANK
ON First5_RANK.hospital_name = Last5_RANK.hospital_name;

--Ranking the categories scores. 
DROP TABLE FINAL_TIME;
CREATE TABLE FINAL_TIME AS
SELECT hospital_name, emr_rank, sci_rank, asth_rank, hf_rank, sc_rank, pneu_rank, prev_rank, BC_rank, heart_rank, preg_rank,
(emr_rank + sci_rank + asth_rank + hf_rank + sc_rank + pneu_rank + prev_rank + BC_rank + heart_rank + preg_rank)/10 AS test_avg
FROM TIME_SUMMARY
ORDER BY test_avg ASC;

--Print top 10 result 
SELECT * FROM FINAL_TIME LIMIT 10;
