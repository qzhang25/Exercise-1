--New descending table of “Emergency Department” average score sort by state. 
DROP TABLE StateEMR_AVG;
CREATE TABLE StateEMR_AVG AS
SELECT state, AVG(score) AS emr_avg_score FROM ERdiagram_effective_time WHERE condition = 'Emergency Department'
GROUP BY state
ORDER BY emr_avg_score DESC;

--New descending table of “Surgical Care Improvement” average scores sort by state.
DROP TABLE StateSCI_AVG;
CREATE TABLE StateSCI_AVG AS
SELECT state, AVG(score) AS sci_avg_score FROM ERdiagram_effective_time WHERE condition = 'Surgical Care Improvement Project'
GROUP BY state
ORDER BY sci_avg_score DESC;

--New descending table of “Children’s Asthma” average scores sort by state. 
DROP TABLE StateASTH_AVG;
CREATE TABLE StateASTH_AVG AS
SELECT state, AVG(score) AS asth_avg_score FROM ERdiagram_effective_time WHERE meas_id = 'CAC_3'
GROUP BY state
ORDER BY asth_avg_score DESC;

--New descending table of “Heart Failure” average scores sort by state. 
DROP TABLE StateHF_AVG;
CREATE TABLE StateHF_AVG AS
SELECT state, AVG(score) AS hf_avg_score FROM ERdiagram_effective_time WHERE condition = 'Heart Failure'
GROUP BY state
ORDER BY hf_avg_score DESC;

--New descending table of “Stroke Care” average scores sort by state.
DROP TABLE StateSC_AVG;
CREATE TABLE StateSC_AVG AS
SELECT state, AVG(score) AS sc_avg_score FROM ERdiagram_effective_time WHERE condition = 'Stroke Care'
GROUP BY state
ORDER BY sc_avg_score DESC;


--combing Emergency Department with Surgical Care Improvement score by state on average.
DROP TABLE StateJOIN1;
CREATE TABLE StateJOIN1 AS
SELECT StateEMR_AVG.state, StateEMR_AVG.emr_avg_score, StateSCI_AVG.sci_avg_score
FROM StateEMR_AVG
INNER JOIN StateSCI_AVG
ON StateEMR_AVG.state = StateSCI_AVG.state;



--combining SJOIN1 with Children’s Asthma Scores by state on average.
DROP TABLE StateJOIN2;
CREATE TABLE StateJOIN2 AS
SELECT StateASTH_AVG.state, StateASTH_AVG.asth_avg_score, StateJOIN1.emr_avg_score, StateJOIN1.sci_avg_score
FROM StateASTH_AVG
INNER JOIN StateJOIN1
ON StateJOIN1.state = StateASTH_AVG.state;

----combining SJOIN2 with Heart Failure scores by state on average.
DROP TABLE StateJOIN3;
CREATE TABLE StateJOIN3 AS
SELECT StateHF_AVG.state, StateHF_AVG.hf_avg_score, StateJOIN2.emr_avg_score, StateJOIN2.sci_avg_score, StateJOIN2.asth_avg_score
FROM StateHF_AVG
INNER JOIN StateJOIN2
ON StateJOIN2.state = StateHF_AVG.state;

--combining SJOIN3 with Stroke Care score by state on average.
DROP TABLE StateJOIN4;
CREATE TABLE StateJOIN4 AS
SELECT StateSC_AVG.state, StateSC_AVG.sc_avg_score, StateJOIN3.emr_avg_score, StateJOIN3.sci_avg_score, StateJOIN3.asth_avg_score, StateJOIN3.hf_avg_score
FROM StateSC_AVG
INNER JOIN StateJOIN3
ON StateJOIN3.state = StateSC_AVG.state;

--Rank table for the  columns from StateJOIN9
DROP TABLE StateTIME_RANK;
CREATE TABLE StateTIME_RANK AS
SELECT state,
RANK() OVER (ORDER BY emr_avg_score DESC) AS emr_rank,
RANK() OVER (ORDER BY sci_avg_score DESC) AS sci_rank,
RANK() OVER (ORDER BY asth_avg_score DESC) AS asth_rank,
RANK() OVER (ORDER BY hf_avg_score DESC) AS hf_rank,
RANK() OVER (ORDER BY sc_avg_score DESC) AS sc_rank
FROM StateJOIN4;

--getting the average score for all categories by states
DROP TABLE Statetime_FIN;
CREATE TABLE Statetime_FIN AS
SELECT state, emr_rank, sci_rank, asth_rank, hf_rank, sc_rank,
(emr_rank + sci_rank + asth_rank + hf_rank + sc_rank )/5 AS test_avg
FROM Statetime_RANK
ORDER BY test_avg ASC;

--list top 10 states
SELECT * FROM Statetime_FIN LIMIT 10;
