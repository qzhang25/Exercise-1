--Emergeny Department Average Table 
DROP TABLE Emergency_AVG;
CREATE TABLE Emergency_AVG AS
SELECT hospital_name, AVG(score) AS emergency_avg_score FROM ERdiagram_effective_time WHERE condition = 'Emergency Department'
GROUP BY hospital_name
ORDER BY emergency_avg_score DESC;

--Surgical Care Average table
DROP TABLE Surgicalcare_AVG;
CREATE TABLE Surgicalcare_AVG AS
SELECT hospital_name, AVG(score) AS scarei_avg_score FROM ERdiagram_effective_time WHERE condition = 'Surgical Care Improvement Project'
GROUP BY hospital_name
ORDER BY scarei_avg_score DESC;

--Children’s Asthma Average Table. 
DROP TABLE childrenasthma_AVG;
CREATE TABLE childrenasthma_AVG AS
SELECT hospital_name, AVG(score) AS childasth_avg_score FROM ERdiagram_effective_time WHERE meas_id = 'CAC_3'
GROUP BY hospital_name
ORDER BY childasth_avg_score DESC;

--Heart Failure Average Table.
DROP TABLE Heartfailure_AVG;
CREATE TABLE Heartfailure_AVG AS
SELECT hospital_name, AVG(score) AS hospitalf_avg_score FROM ERdiagram_effective_time WHERE condition = 'Heart Failure'
GROUP BY hospital_name
ORDER BY hospitalf_avg_score DESC;

--Stroke Care Average Table .
DROP TABLE StrokeC_AVG;
CREATE TABLE StrokeC_AVG AS
SELECT hospital_name, AVG(score) AS strokec_avg_score FROM ERdiagram_effective_time WHERE condition = 'Stroke Care'
GROUP BY hospital_name
ORDER BY strokec_avg_score DESC;

--Combining Emergency and Surfical two tables
DROP TABLE COMBINE1;
CREATE TABLE COMBINE1 AS
SELECT Emergency_AVG.hospital_name, Emergency_AVG.emergency_avg_score, Surgicalcare_AVG.scarei_avg_score
FROM Emergency_AVG
INNER JOIN Surgicalcare_AVG
ON Emergency_AVG.hospital_name = Surgicalcare_AVG.hospital_name;

--Combining previouse one with children asthma table
DROP TABLE COMEBINE2;
CREATE TABLE COMEBINE2 AS
SELECT childrenasthma_AVG.hospital_name, childrenasthma_AVG.childasth_avg_score, COMBINE1.emergency_avg_score, COMBINE1.scarei_avg_score
FROM childrenasthma_AVG
INNER JOIN COMBINE1
ON COMBINE1.hospital_name = childrenasthma_AVG.hospital_name;

--Combing previous one with hearth failure table
DROP TABLE COMBINE3;
CREATE TABLE COMBINE3 AS
SELECT Heartfailure_AVG.hospital_name, Heartfailure_AVG.hospitalf_avg_score, COMEBINE2.emergency_avg_score, COMEBINE2.scarei_avg_score, COMEBINE2.childasth_avg_score
FROM Heartfailure_AVG
INNER JOIN COMEBINE2
ON COMEBINE2.hospital_name = Heartfailure_AVG.hospital_name;

--Combining previous one with stroke table.
DROP TABLE COMBINE4;
CREATE TABLE COMBINE4 AS
SELECT StrokeC_AVG.hospital_name, StrokeC_AVG.strokec_avg_score, COMBINE3.emergency_avg_score, COMBINE3.scarei_avg_score, COMBINE3.childasth_avg_score, COMBINE3.hospitalf_avg_score
FROM StrokeC_AVG
INNER JOIN COMBINE3
ON COMBINE3.hospital_name = StrokeC_AVG.hospital_name;


--Rank table for the categories which created aboved.
DROP TABLE First4_RANK;
CREATE TABLE First4_RANK AS
SELECT hospital_name,
RANK() OVER (ORDER BY emergency_avg_score DESC) AS emergency_rank,
RANK() OVER (ORDER BY scarei_avg_score DESC) AS scarei_rank,
RANK() OVER (ORDER BY childasth_avg_score DESC) AS childasth_rank,
RANK() OVER (ORDER BY hospitalf_avg_score DESC) AS hospitalf_rank,
RANK() OVER (ORDER BY strokec_avg_score DESC) AS strokec_rank
FROM COMBINE4;

--Final time evaluation table. 
DROP TABLE FINAL_TIM;
CREATE TABLE FINAL_TIM AS
SELECT hospital_name, emergency_rank, scarei_rank, childasth_rank, hospitalf_rank,strokec_rank,
(emergency_rank + scarei_rank + childasth_rank + hospitalf_rank + strokec_rank)/5 AS final_avg
FROM First4_RANK
ORDER BY final_avg DESC;

--Print top 10 result 
SELECT * FROM FINAL_TIM LIMIT 10;
