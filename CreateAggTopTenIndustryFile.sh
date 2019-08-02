#!/bin/bash
# # # # # # # # # # # # # # 

#####################################################################################
# Concat all of the output files that have been run for one simulation.
#####################################################################################
data="Data"
results="FinalResults"
setup="IMPLAN Simulation Set-up Files/IMPLAN County Overview Files/csv files"

cd "$data/$setup"

input="MIcounties.csv"

filename="AggTopTenIndustryFile.csv"

echo "county,industry,description,notused1,notused2,employment,laborinc,output" > $filename

# the 'while, do, done < "$input" formula reads in a file line by line and saves the line in the local variable indicated, e.g. county' 
# awk prints (or does other processes) particular parts of lines from a file 
# sed picks particular lines 
# cut picks particular fields (columns) 

while IFS= read -r county
do
		cat *"$county"*csv | \
		awk -v var1="$county" '{print var1 "," $0}' | \
		sed -n -e '25,34p' >> $filename
		
done < "$input"

exit
