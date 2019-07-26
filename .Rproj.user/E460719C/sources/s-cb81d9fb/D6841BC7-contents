/* BRH Created 06.17.2019 */

/*                                                                                            */
/* This do file reads in the separate raw IO files from Implan and creates IO metrics needed. */
/*                                                                                            */
/* The first INPUT file is AggIOall.csv, which was created using the bash script ConcatIO.sh  */
/* That file reads in all of the raw .csv IO files and concatenated them.                     */
/*                                                                                            */
/* The second INPUT file is the IMPLANVars.csv files containing county-level                  */
/* independent variables from IMPLAN.                                                         */
/*                                                                                            */
/* The third INPUT file is the NonIMPLANVars.csv files containing county-level                */
/* independent variables from other sources than IMPLAN.                                      */
/*                                                                                            */

/* The OUPTUT file is MICountyData, which will contain all of the independent vars and        */
/* IO metrics.                                                                                */
/*                                                                                            */

/****** Read in County Impacts Data (and later, other control vars) ******/
global pgmdir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\Data Management Files"
global datadir "C:\Users\brh22\Google Drive\_ Energy Economics\Sabbatical Project\KN - Implan Research\IMPLAN Independent Vars"

clear
mata mata clear
save "$datadir\MICountyData",replace emptyok

/* Get the concatenated IO files */
	import delimited "$datadir\AggIOall.csv"

/* convert all missing values to 0 */
	mvencode *,mv(0) 
	save tempIO, replace

/* Get each county's IO matrix and compute Bonacich centrality measures. */

levelsof county, local(names)

/*                                                                                            */
/*    Begin FOREACH loop over all counties                                                    */
/*                                                                                            */
foreach name of local names {
	use tempIO, clear
	preserve
		keep if county == "`name'"
		keep if sector == "Total"
		drop county sector

/*                                                                                            */
/* First, get Total Industry Output row vector                                                */
/* Use it to make into a new variable, TotIndOut, using getmata.                              */
/* Next, diagonalize the inverse of it (ghat_inv) to multiply the IO table by                 */
/* where each element of the column of IO table is divided through by                         */
/* the total output for each industry.                                                        */
/* This gives the Direct Requirements matrix in value of input needed for $1 of output of the industry. */
/* NOTE: The Total industry output is a row of the input file, but is contains the            */
/* same as numbers as a column containing the row totals which is what is needed for the calculation. */
/*                                                                                            */		
		mata TotIndOut = st_data(.,.)'
		mata ghat_inv = luinv(diag(TotIndOut))

/* Now, entire IO matrix for just this county*/	
	restore
		keep if county == "`name'"
		drop if sector == "Total"
		drop county sector

/*                                                                                            */	
/* Calculate A matrix (Direct Requirements)                                                   */
/* Create by dividing each IO column by Total Industry Output (TIO).                          */
/* In IMPLAN, the column of the IO matrix is the output. Rows are recipes                     */
/* TIO was a row in the IMPLAN IO matrix. It is inverted and diagonalized above.              */
/*                                                                                            */	
		mata IO = st_data(.,.)
		mata A = IO*ghat_inv
		
/* Calculate Leontief Inverse Matrix (Total Requirements Matrix) */
		mata L = luinv(I(rows(A))-A)
		mata lsize = rows(L)
		mata st_local("lsize", strofreal(lsize))  /* turns the number of rows calculated in mata into a local variable for use later */
		
/* Calculate Final Demand for each sector */
		mata Y = luinv(L)*TotIndOut               /* TotXOut = L*Y  so to get Final Demand, calculate Y = Linv * TotXOut*/

/* Save these metrics by county */
		gen county = "`name'"
		gen sector = _n
		gen shocksector = 0
		
		getmata TotIndOut, force
		getmata  Y, force		
		getmata (l_*)=L, force

/* Calculate Concentration Centrality for each sector = stdev of leontief inverse outflows for each sector */
		egen Bona_cent = rowtotal(l_1 - l_`lsize')   /* total outdegree of each sector */
		egen Conc_cent = rowsd(l_1 - l_`lsize')      /* sd of outdegree of each sector */
		
/* Add the 0 sector to match with the results */													 
		set obs 12
		replace county = "`name'" if _n == 12
		replace sector = 0 if _n == 12	
		 
		egen B_mean = mean(Bona_cent)                /* avg Bonacich centrality for county */
		egen C_mean = mean(Conc_cent)                /* avg Concentration centrality for county */
		egen B_sd = sd(Bona_cent)                    /* sd of Bonacich centrality for county */
		egen C_sd = sd(Conc_cent)                    /* sd of Concentration centrality for county */
		drop l_*  /* to move L and IO to the end of the variable list */
		getmata (l_*)=L, force
		getmata (s_*)=IO, force

		drop s1-s11                                  /* drop the original Implan IO matrix */	

		sort county sector    
		
		save temp1,replace
		use "$datadir\MICountyData", clear
			append using temp1
			save "$datadir\MICountyData", replace
/*                                                                                            */
/*    End FOREACH loop                                                                        */
/*                                                                                            */
}

/*                                                                                            */
/*    Merge the other Independent Vars                                                        */
/*                                                                                            */
		import delimited "$datadir\NonIMPLANVars.csv", clear
			save temp2, replace
		import delimited "$datadir\IMPLANVars.csv", clear
			merge 1:1 county using temp2
			drop _merge
			save temp3,replace
			
	use "$datadir\MICountyData", clear
		merge m:1 county using temp3
		drop _merge
		save "$datadir\MICountyData", replace

/* Clean up */
erase temp1.dta
erase temp2.dta
erase temp3.dta
erase tempIO.dta