--State Emergency Department table. 
DROP TABLE StateEMR_AVG;
CREATE TABLE StateEMR_AVG AS
SELECT state, AVG(score) AS emergency_avg_score FROM ERdiagram_effective_time WHERE condition = 'Emergency Department'
GROUP BY state
ORDER BY emergency_avg_score DESC;

--State Surgical Care table.
DROP TABLE StateSCI_AVG;
CREATE TABLE StateSCI_AVG AS
SELECT state, AVG(score) AS scarei_avg_score FROM ERdiagram_effective_time WHERE condition = 'Surgical Care Improvement Project'
GROUP BY state
ORDER BY scarei_avg_score DESC;

--State Children’s Asthma table. 
DROP TABLE StateASTH_AVG;
CREATE TABLE StateASTH_AVG AS
SELECT state, AVG(score) AS childasth_avg_score FROM ERdiagram_effective_time WHERE meas_id = 'CAC_3'
GROUP BY state
ORDER BY childasth_avg_score DESC;

--State Heart Failure table. 
DROP TABLE StateHF_AVG;
CREATE TABLE StateHF_AVG AS
SELECT state, AVG(score) AS hospitalf_avg_score FROM ERdiagram_effective_time WHERE condition = 'Heart Failure'
GROUP BY state
ORDER BY hospitalf_avg_score DESC;

--State Stroke Care table.
DROP TABLE StateSC_AVG;
CREATE TABLE StateSC_AVG AS
SELECT state, AVG(score) AS strokec_avg_score FROM ERdiagram_effective_time WHERE condition = 'Stroke Care'
GROUP BY state
ORDER BY strokec_avg_score DESC;


--Combining Emergency with Surgical Care table.
DROP TABLE StateJOIN1;
CREATE TABLE StateJOIN1 AS
SELECT StateEMR_AVG.state, StateEMR_AVG.emergency_avg_score, StateSCI_AVG.scarei_avg_score
FROM StateEMR_AVG
INNER JOIN StateSCI_AVG
ON StateEMR_AVG.state = StateSCI_AVG.state;



--Combining previous one with Asthema Table.
DROP TABLE StateJOIN2;
CREATE TABLE StateJOIN2 AS
SELECT StateASTH_AVG.state, StateASTH_AVG.childasth_avg_score, StateJOIN1.emergency_avg_score, StateJOIN1.scarei_avg_score
FROM StateASTH_AVG
INNER JOIN StateJOIN1
ON StateJOIN1.state = StateASTH_AVG.state;

----Combining previous one with Heart Failure table.
DROP TABLE StateJOIN3;
CREATE TABLE StateJOIN3 AS
SELECT StateHF_AVG.state, StateHF_AVG.hospitalf_avg_score, StateJOIN2.emergency_avg_score, StateJOIN2.scarei_avg_score, StateJOIN2.childasth_avg_score
FROM StateHF_AVG
INNER JOIN StateJOIN2
ON StateJOIN2.state = StateHF_AVG.state;

--Combining previous one with Stroke table
DROP TABLE StateJOIN4;
CREATE TABLE StateJOIN4 AS
SELECT StateSC_AVG.state, StateSC_AVG.strokec_avg_score, StateJOIN3.emergency_avg_score, StateJOIN3.scarei_avg_score, StateJOIN3.childasth_avg_score, StateJOIN3.hospitalf_avg_score
FROM StateSC_AVG
INNER JOIN StateJOIN3
ON StateJOIN3.state = StateSC_AVG.state;

--Rank the previous table
DROP TABLE StateTIME_RANK;
CREATE TABLE StateTIME_RANK AS
SELECT state,
RANK() OVER (ORDER BY emergency_avg_score DESC) AS emrgency_rank,
RANK() OVER (ORDER BY scarei_avg_score DESC) AS scarei_rank,
RANK() OVER (ORDER BY childasth_avg_score DESC) AS childasth_rank,
RANK() OVER (ORDER BY hospitalf_avg_score DESC) AS hospitalf_rank,
RANK() OVER (ORDER BY strokec_avg_score DESC) AS strokec_rank
FROM StateJOIN4;

--Get the summary table
DROP TABLE Statetime_FIN;
CREATE TABLE Statetime_FIN AS
SELECT state, emrgency_rank, scarei_rank, childasth_rank, hospitalf_rank, strokec_rank,
(emrgency_rank + scarei_rank + childasth_rank + hospitalf_rank + strokec_rank )/5 AS summary_avg
FROM Statetime_RANK
ORDER BY summary_avg DESC;

--list top 10 states
SELECT * FROM Statetime_FIN LIMIT 10;
