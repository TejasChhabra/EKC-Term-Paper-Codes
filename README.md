# EKC-Term-Paper-Codes

This section talks about the datasets used. This code looks to test the EKC hypothesis and the other EKC scenarios in the context of developed and developing South Asian countries. The countries this code looks to analyse are – Bangladesh, China, India, Indonesia, Nepal, Thailand, Malaysia, South Korea, Taiwan, UAE, Singapore, Japan and Philippines.
 
For Carbon Emissions, the data comes from the Oak Ridge National Laboratory’s Carbon Dioxide Information Analysis Center (CDIAC). The variable considered is total carbon emissions per capita from fuel consumption net of gas flaring. 
 
The code uses Penn World Table version 10.01 to generate GDP per capita values for different countries across time. This data is an updated version as compared to version 5.0 used in the 1995 paper by Holtz-Eiken and Selden (Holtz-Eiken, Selden,1995). In their paper Holtz-Eiken and Selden use the "RGDPCH" series in 1986 USD as a measure of GDP (Holtz-Eiken, Selden,1995). This series is no longer available. For the purpose of this paper, the "RGDPE" series is used,   as the expenditure-based GDP values are a better measure for comparing relative living standards. The "RGDPE" series captures expenditure-side real GDP at chained PPPs in millions of 2017 USD. Given that the literature referenced considers 1986 USD (Holtz-Eiken, Selden,1995), this paper utilises a CPI deflator to convert the 2017 USD values to 1986 USD values in order to obtain comparable results.  
 
For sulphur dioxide emissions, the code uses Anthropogenic Sulphur Dioxide Emissions from the National and Rural Data Set by Source Category, version 2.86 which is distributed by the NASA Socioeconomic Data and Applications Centre (SEDAC).

A merged data set was created with all these variables which is then called upon by the R code. The code has then used the subsetted data set from R to run the regressions in stata. 

In R, the code is used to perform subsetting of a large data set, provide descriptive statistics and visualizations to motivate the study. Quadratic regressions of the kind in the original EKC hypothesis (Holtz-Eiken, Selden,1995) are run here. 

Time lag regressions are then run on this subsetted data in STATA to test out the revised EKC hypothesis suggested by the current literature. (Dasgupta et al, 2002)
