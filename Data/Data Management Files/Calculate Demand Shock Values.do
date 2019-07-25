/* BRH Created 06.17.2019 */

/*                                                                                            */
/* This do file reads in the separate raw IO files from Implan and creates the Activity       */
/* files for IMPLAN as .csv files.                                                            */
/*                                                                                            */
/*  An Excel macro reads in the .csv files to create the .xls files for IMPLAN to read in.    */                                                                                          */
/*  The Excel macro is in "Convert csv to xls.xlsm" in the Data Management Files folder       */                                                                                         */
/*                                                                                            */

global pgmdir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\Data Management Files"
global datadir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\IMPLAN Independent Vars"
global setupdir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\IMPLAN Simulation Set-up Files"

clear
mata mata clear
use "$datadir\MICountyData"

keep if sector==6
gen sec395drop01pct = Y*-.01  /*** set the pct drop value here *****/

keep county sec395drop01pct

export delimited using "$setupdir\DemandShockValues01pct.csv", novarnames replace

