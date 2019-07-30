#!/bin/bash
# # # # # # # # # # # # # # 


#####################################################################################
# Concat all of the output files that have been run for one simulation.
#####################################################################################
data="Data"
IOfiles="IMPLAN IO Tables"

cd "$data/$IOfiles"
ls *Regional*.csv | awk '{if ($2 ~ /Regional/) print $1; else print $1 " " $2}' > temp1

input="temp1"

echo "county,sector,desc,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11" > AggIOall.csv

# the 'while, do, done < "$input" formula reads in a file line by line and saves the line in the local variable indicated, e.g. county' 
# awk prints (or does other processess) particular parts of lines from a file 
# sed picks particular lines 

while IFS= read -r county
do
	cat "$county"*.csv | \
	awk -v var="$county"  '{print var "," $0}' | \
	sed -n -e '3,13p' -e '38p'  >> AggIOall.csv
	#|\
	#cut -d "," -f 1,3-13   >> AggIOall.csv

done < "$input"

# rm temp1
exit
