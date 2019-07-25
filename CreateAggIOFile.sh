#!/bin/bash
# # # # # # # # # # # # # # 


#####################################################################################
# Concat all of the output files that have been run for one simulation.
#####################################################################################
gdrive="/mnt/c/Users/brh22/Google Drive"
implan="/mnt/c/Users/brh22/Google Drive/_ Energy Economics/Sabbatical Project/KN - Implan Research"
pgms="Data Management Files"
indepvars="IMPLAN Independent Vars"
IOfiles="IMPLAN IO Tables"
results="IMPLAN Simulation Results/FinalResults"
setup="IMPLAN Simulation Set-up Files"
analysis="Research Analysis in R"

cd "$implan/$indepvars/$IOfiles"
ls *Regional*.csv| awk '{if ($2 ~ /Regional/) print $1; else print $1 " " $2}' > temp1

input="temp1"

echo "county,sector,desc,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11" > AggIOall.csv

# the 'while, do, done < "$input" formula reads in a file line by line and saves the line in the local variable indicated, e.g. county' 
# awk prints (or does other processess) particular parts of lines from a file 
# sed picks particular lines 
# cut picks particular fields (columns)  | cut -d ',' -f 1,2,4-14

while IFS= read -r county
do
	cat "$county"*.csv | awk -v var="$county"  --field-separator ',' '{print var "," $0}' | \
	sed -n -e '3,13p' -e '38p'  >> AggIOall.csv

done < "$input"

rm temp1
exit
