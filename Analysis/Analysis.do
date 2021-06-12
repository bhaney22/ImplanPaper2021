/* BRH Created 07.11.2019 */

/*                                                                                            */
/* This do file reads in the Stata Results file and performs analysis.                        */
/* for analysis.                                                                              */
/*                                                                                            */
/*                                                                                            */

/****** Read in County Impacts Data (and later, other control vars) ******/
global simdir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\IMPLAN Simulation Results"
use "$simdir\shock01", clear
preserve 

        
drop if sector !=0

twoway (scatter pctinddrop B_mean, mlabel(county)), title(Add'l Indirect for a $1 Demand Shock to Wholesale Trade)

restore