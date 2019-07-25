#!/bin/bash
# # # # # # # # # # # # # # 
#####################################################################################
# Get Independent Vars from the County Overview files 
#####################################################################################

cd ~/Implan/"IMPLAN County Overview Files"/"csv files"

input="/home/brh22/Implan/MIcounties.txt"

echo "county,year,grp,tpi,totemp,numind,area,pop,numhh,avghhinc,swindex" > ~/Implan/IMPLANVars.csv

# the 'while, do, done < "$input" formula reads in a file line by line and saves the line in the local variable indicated, e.g. county' 
# awk prints (or does other processes) particular parts of lines from a file 
# sed picks particular lines 
# cut picks particular fields (columns) 
# var=$(command) stores the results of the command in the variable

while IFS= read -r county
do
	cat *"$county"*csv | sed -n -e 4,7p -e 9,10p -e 13,15p -e 21p  | cut -d ',' -f 3 > temp2 
	year=$(cat temp2 | sed -n 1p) 
	grp=$(cat temp2 | sed -n 2p) 
	tpi=$(cat temp2 | sed -n 3p) 
	totemp=$(cat temp2 | sed -n 4p) 
	numind=$(cat temp2 | sed -n 5p) 
	area=$(cat temp2 | sed -n 6p) 
	pop=$(cat temp2 | sed -n 7p) 
	numhh=$(cat temp2 | sed -n 8p) 
	avghhinc=$(cat temp2 | sed -n 9p) 
	swindex=$(cat temp2 | sed -n 10p) 
	echo "$county,$year,$grp,$tpi,$totemp,$numind,$area,$pop,$numhh,$avghhinc,$swindex"  >> ~/Implan/IMPLANVars.csv

done < "$input"

exit