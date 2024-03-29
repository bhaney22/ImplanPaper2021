/* BRH Created 06.17.2019 */
/* BRH Revised 01.28.2020 */

/*                                                                                            */
/* This do file reads in the MICountyData and Agg Scenario Results file to create one file    */
/* for analysis.                                                                              */
/*                                                                                            */
/*                                                                                            */

/****** Read in County Impacts Data (and later, other control vars) ******/
global pgmdir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\Data Management Files"
global datadir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\IMPLAN Independent Vars"
global simdir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\IMPLAN Simulation Results"

/*                                                                                            */
/*   IMPORTANT: Set the shocksector variable to the number of the sector that was shocked.    */
/*   Wholesale Trade is sector 6 in IMPLAN's 11 sector scheme.                                */
/*                                                                                            */
local shocksector 6      
 /*** CAUTION: Change the percent of the shock in two places below - search on HERE ***/

clear
mata mata clear

/* Get the concatenated IO files */
use "$simdir\SimResultsAll"

/* Clean up names and sectors */
replace sector=01 if sector==1
replace sector=02 if sector==20
replace sector=03 if sector==41
replace sector=04 if sector==52
replace sector=05 if sector==65
replace sector=06 if sector==395
replace sector=07 if sector==396
replace sector=08 if sector==408
replace sector=09 if sector==417
replace sector=10 if sector==472
replace sector=11 if sector==520 | sector==518


/*                                                                                            */
/*    Merge with the Independent Vars                                                         */
/* 
                                                                                    */
sort year county sector
		merge 1:1 year county sector using "$datadir\MICountyData"
		drop _merge

/* record the centrality measures from the shocked sector observation*/
		replace Bona_cent = Bona_cent[_n+`shocksector'] if sector == 0 
		replace Conc_cent = Conc_cent[_n+`shocksector'] if sector == 0
		replace shocksector=1 if sector == `shocksector'
		replace shocksector=`shocksector' if sector == 0

/* calculate the percent total drop */
		gen pcttotdrop = 100*(total/grp) if sector==0  
		gen pctadddrop = ((total - direct)/direct)*100  
		gen pctinddrop = ((indirect - direct)/direct)*100 
		gen pctinduced= ((induced - indirect)/indirect)*100 

save "$simdir\shock01", replace                                    /* HERE */


