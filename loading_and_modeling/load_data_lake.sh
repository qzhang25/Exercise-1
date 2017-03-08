	#Download file from the website
wget -O hosp.zip https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip
	
  
	#Unzip file
	unzip hosp.zip


	#Rename file 
	tail -n+2 "Hospital General Information.csv" > "hospitals.csv"
	tail -n+2 "Timely and Effective Care - Hospital.csv" > "effective_care.csv"
	tail -n+2 "Readmissions and Deaths - Hospital.csv" > "readmissions.csv"
	tail -n+2 "Measure Dates.csv" > "Measures.csv"
	tail -n+2 "hvbp_hcahps_05_28_2015.csv" > "surveys_responses.csv"
	

	#Adding hospital compare
	hdfs dfs -mkdir /user/w205/hospital_compare
	

	#Adding a folder to store the data above
	hdfs dfs -mkdir /user/w205/hospital_compare/qinghos_gen
	hdfs dfs -mkdir /user/w205/hospital_compare/t_eff
	hdfs dfs -mkdir /user/w205/hospital_compare/dates
	hdfs dfs -mkdir /user/w205/hospital_compare/su_res
	hdfs dfs -mkdir /user/w205/hospital_compare/read_deaths

	#Loading data
	hdfs dfs -put hospitals.csv /user/w205/hospital_compare/qinghos_gen
	hdfs dfs -put effective_care.csv /user/w205/hospital_compare/t_eff
	hdfs dfs -put Measures.csv /user/w205/hospital_compare/dates
	hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/su_res
	hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmission_deaths

