/* BRH Created 07.11.2019 */
/* BRH Revised to analyze all three years 01.28.2020 */
/*                                                                                            */
/* This do file reads in the Stata Results file and performs analysis.                        */
/* for analysis.                                                                              */
/*                                                                                            */
/*                                                                                            */

/****** Read in County Impacts Data (and later, other control vars) ******/
global simdir "C:\Users\bhane\Google Drive\Sabbatical Project\KN - Implan Research\IMPLAN Simulation Results"
use "$simdir\shock01", clear 
    
drop if sector !=0

preserve
keep if year==2001
twoway (scatter pctinddrop B_mean), title(Add'l Indirect for a $1 Demand Shock to Wholesale Trade) subtitle(2001)

restore

preserve
keep if year==2006
twoway (scatter pctinddrop B_mean), title(Add'l Indirect for a $1 Demand Shock to Wholesale Trade) subtitle(2006)

restore

preserve
keep if year==2014
twoway (scatter pctinddrop B_mean), title(Add'l Indirect for a $1 Demand Shock to Wholesale Trade) subtitle(2014)

restore

preserve
keep if year==2001
twoway (scatter pctinddrop B_sd), title(Add'l Indirect for a $1 Demand Shock to Wholesale Trade) subtitle(2001)

restore

preserve
keep if year==2006
twoway (scatter pctinddrop B_sd), title(Add'l Indirect for a $1 Demand Shock to Wholesale Trade) subtitle(2006)

restore

preserve
keep if year==2014
twoway (scatter pctinddrop B_sd), title(Add'l Indirect for a $1 Demand Shock to Wholesale Trade) subtitle(2014)

restore