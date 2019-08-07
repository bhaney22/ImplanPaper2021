#!/bin/bash
# # # # # # # # # # # # # # 

#####################################################################################
# Concat all of the output files that have been run for one simulation.
#####################################################################################

year="2014"    ### SET THE YEAR for the Simulation

g="/mnt/c/Users/brh22/Google Drive"
IMPLAN="_ Energy Economics/Sabbatical Project/KN - Implan Research"
setup="IMPLAN Simulation Set-up Files/$year/IMPLAN Overview Files TopTen by Output/csv"

rhome="/mnt/c/Users/brh22/Documents/R Projects/Implan Paper"
input="$rhome/MIcounties.csv"
outfilename="$rhome/AggTopTenIndustryFileOutput$year.csv"

cd "$g/$IMPLAN/$setup"
echo "county,year,industry,description,notused1,notused2,\
employment,laborinc,output" > $outfilename

while IFS= read -r county
do
		cat *"$county"*csv | \
		awk -v var1="$county" -v var2="$year" '{print var1 "," var2 "," $0}' | \
		sed -n -e '25,34p' >> $outfilename
		
done < "$input"

exit
