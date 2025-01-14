** Using the subsetted data set from the R code

encode countryy, gen(id) //this generates numeric values for your nation variable (it is string)
xtset id year // this sets panel as id and year
destring co2pc, replace // makes the co2pc variable numeric from string

// replacing the NA data points to . and destringing the variables
foreach var of varlist co2pc gdppc so2pc{
replace `var' = "." if `var'=="NA"
destring `var', replace
}

** Running a Time Lag quadratic regression for co2pc with year fixed effects and clustering of the standard error at the panel level.
xtreg co2pc gdppc c.gdppc#c.gdppc l.co2pc i.year, fe cl(id)  
** Finding the turning point
nlcom _b[gdppc]/(2*_b[c.gdppc#c.gdppc])

** Running the same regression for so2pc
xtreg so2pc gdppc c.gdppc#c.gdppc l.so2pc i.year, fe cl(id) // the time dynamic regression 
** Finding the turning point
nlcom _b[gdppc]/(2*_b[c.gdppc#c.gdppc])
