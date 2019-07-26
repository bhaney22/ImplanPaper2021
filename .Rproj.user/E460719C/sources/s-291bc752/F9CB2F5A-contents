#!/bin/bash
# # # # # # # # # # # # # # 

#####################################################################################
# Concat all of the output files that have been run for one simulation.
#####################################################################################
data="Data"
results="FinalResults"


cd "$data/$results"

table=Output
filename=AggResults01pct.csv

ls *$table*.csv| awk '{if ($2 ~ /Scenario/) print $1; else print $1 " " $2}' > temp1

input="temp1"

echo "county,table,sector,description,direct,indirect,induced,total" > $filename

# the 'while, do, done < "$input" formula reads in a file line by line and saves the line in the local variable indicated, e.g. county' 
# awk prints (or does other processes) particular parts of lines from a file 
# sed picks particular lines 
# cut picks particular fields (columns) 

while IFS= read -r county
do
	for table in Output Employment 
	do
		cat "$county"*"$table".csv | \
		  awk -v var1="$county" -v var2="$table" '{print var1 "," var2 "," $0}' | \
			sed -n -e '3,14p' >> $filename
	done

done < "$input"

rm temp1
exit
