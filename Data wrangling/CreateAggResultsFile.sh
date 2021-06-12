#!/bin/bash
# # # # # # # # # # # # # # 

#####################################################################################
# Concat all of the output files that have been run for one simulation.
#####################################################################################
year="2014"    ### SET THE YEAR for the Simulation

g="/mnt/c/Users/brh22/Google Drive"
IMPLAN="_ Energy Economics/Sabbatical Project/KN - Implan Research"
setup="IMPLAN Simulation Set-up Files/$year/IMPLAN Overview Files TopTen by Output/csv"
IOfiles="IMPLAN IO Tables/$year"
results="IMPLAN Simulation Results/$year"

rhome="/mnt/c/Users/brh22/Documents/R Projects/Implan Paper"
data="Data"
input="$rhome/$data/MIcounties.csv"
outfilename="Aggresults$year.csv"

cd "$g/$IMPLAN/$results"

echo "county,year,table,sector,description,direct,indirect,induced,total" > $outfilename

while IFS= read -r county
do
	for table in Output  
	do
		cat "$county"*"$table".csv | \
		  awk -v var1="$county" -v var2="$year" -v var3="$table" '{print var1 "," var2 "," var3 "," $0}' | \
			sed -n -e '3,14p' >> $outfilename
	done

done < "$input"

cp $outfilename "$rhome/$data/"
exit
