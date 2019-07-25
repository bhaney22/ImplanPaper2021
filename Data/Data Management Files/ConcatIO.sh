#!/bin/bash
# # # # # # # # # # # # # # 


#####################################################################################
# Concat all of the output files that have been run for one simulation.
#####################################################################################
cd ~/Implan/"Raw IO files"/"IMPLAN Aggregate Input-Output Raw Files"
ls *.csv| awk '{if ($2 ~ /Regional/) print $1; else print $1 " " $2}' > ~/Implan/MIcounties.txt

input="/home/brh22/Implan/MIcounties.txt"

echo "county,sector,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11" > ~/Implan/AggIOall.csv

# the 'while, do, done < "$input" formula reads in a file line by line and saves the line in the local variable indicated, e.g. county' 
# awk prints (or does other processess) particular parts of lines from a file 
# sed picks particular lines 
# cut picks particular fields (columns) 

while IFS= read -r county
do
	cat "$county"*.csv | awk -v var="$county"  --field-separator ',' '{print var "," $0}' | sed -n -e '3,13p' -e '38p' | cut -d ',' -f 1,2,4-14 >> ~/Implan/AggIOall.csv

done < "$input"

exit