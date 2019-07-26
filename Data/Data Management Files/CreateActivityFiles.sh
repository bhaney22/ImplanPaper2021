#!/bin/bash
# # # # # # # # # # # # # # 
#####################################################################################
# Concat all of the output files that have been run for one simulation.
#####################################################################################
 

input="/home/brh22/Implan/DemandShockValues01pct.csv"

while IFS= read -r countyshock
do
	county=$(echo $countyshock | cut -f1 -d,)
	shock=$(echo $countyshock | cut -f2 -d,)

	echo "Activity Type,Activity Name,Activity Level,Activity Year"    > ~/Implan/csvfolder/"$county 01pctDropWholeTrade.csv"				
	echo "Industry Change,01pctDropWholeTrade,1,2014" 	              >> ~/Implan/csvfolder/"$county 01pctDropWholeTrade.csv"	
	echo " "                                                          >> ~/Implan/csvfolder/"$county 01pctDropWholeTrade.csv"		
	echo "Sector,Event Value,Employment,Employee Compensation,\
	      Proprietor Income,Event Year,Retail?,Local Direct Purchase" >> ~/Implan/csvfolder/"$county 01pctDropWholeTrade.csv"
	echo "395,"	$shock ",,,,2014,No,1"                                >> ~/Implan/csvfolder/"$county 01pctDropWholeTrade.csv"

done < "$input"

exit