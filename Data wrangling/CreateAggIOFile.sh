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

rhome="/mnt/c/Users/brh22/Documents/R Projects/Implan Paper" ### 6.11.2018 BH Now in "../Data/AggData"
data="Data"
input="$rhome/$data/MIcounties.csv"
outfilename="AggIOall$year.csv"

cd "$g/$IMPLAN/$IOfiles"
#ls *Regional*.csv | awk '{if ($2 ~ /Regional/) print $1; else print $1 " " $2}' > temp1

input="$input"

echo "county,year,sector,desc,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11" > $outfilename

while IFS= read -r county
do
	cat "$county"*.csv | \
	awk -v var1="$county" -v var2="$year" '{print var1 "," var2 "," $0}' | \
	sed -n -e '3,13p' -e '38p'  >> $outfilename
	#|\
	#cut -d "," -f 1,3-13   >> A$outfilename

done < "$input"

cp $outfilename "$rhome/$data/"

exit
