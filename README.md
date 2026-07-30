# Cost-Effective Recovery Planning for Threatened Species is Robust to Data Uncertainty

**About this repository**

This repository can be cited as:

_Avery-Gomm, S., Iacona, G., Drew, C. A., Maloney, R., Possingham, H., Rumpff, L., Crouse, D., Newman, J., Rogers, A., Runge, M., & Gerber, L. Year TBD. Cost-effective recovery planning for threatened species is robust to data uncertainty. Figshare. https://doi.org/10.6084/m9.figshare.28578413_

This repository contains all data and code necessary to generate manuscript results associated with the following peer-reviewed publication:

_Avery-Gomm, S., Iacona, G., Drew, C. A., Maloney, R., Possingham, H., Rumpff, L., Crouse, D., Newman, J., Rogers, A., Runge, M., & Gerber, L. Year TBD. How robust are conservation prioritization decisions to data uncertainty? A case study using the Project Prioritization Protocol. Journal TBD. DOI TBD._

**Contents**

The **raw data** used in this case study were retrieved from the Environmental Conservation Online System (ECOS) database (http://ecos.fws.gov/ecp/) via a database query on January 10, 2017. These data are available to the public via the Recovery Online Activity Reporting (ROAR) module of the database or can be found in /data/io_2127_b.csv.zip. 

The **formatted data** used in this analysis are provided in **FILE NAME**. To reproduce the analyses performed in this study, use the code provided in **FOLDER NAME** in this sequence: FILE NAME, FILE NAME, FILE NAME.

**(THIS IS AN EXAMPLE)**
**The code** required to reproduce the double count analysis is in reproducible_analysis.R, using the input files data/rawdata.csv and data/multipleruns.csv. The code, including detailed comments, is organized into 8 sections:

1. Load Packages: loads the required packages (see Sofware requirements, below)
2. Import, Restructure, and Subset Data: five subsets of the available data are created to faciliate analyses in sections 3-8
- df: requires data/rawdata.csv; results from the first CountEm run for each photo using 300 quadrats, only considering AOTs (52 rows, 22 columns)
- df_500: requires data/rawdata.csv; CountEm results from a subset of 12 photos using 300 and 500 quadrats, only considering AOTs (12 rows, 10 columns)
- df_dead: requires data/rawdata.csv; results from the first CountEm run for each photo using 300 quadrats, only considering dead birds (4 rows, 22 columns)
- mdf: requires data/multipleruns.csv; results from ten CountEm runs for a subset of 11 photos, only considering AOTs (110 rows, 22 columns)
- mdf_dead: requires data/multipleruns.csv; results from ten CountEm runs for a subset of 11 photos, only considering dead birds (30 rows, 22 columns)

Sections 3-8 are used to generate the results found in the corresponding Results subheaders of the text:

3. Results: CountEm Accuracy: uses the data object dfto assess the use of CountEm to estimate the number of AOTs; produces Figures 3 and 4
4. Results: Increasing CountEm Quadrats: uses the data object df_500 to assess the impact of increasing the number of CountEm quadrats from 300 to 500
5. Results: Estimating the Number of Dead Birds: uses the data object df_dead to assess the use of CountEm to estimate the number of dead birds
6. Results: Accuracy of Multiple CountEm Runs: uses the data object mdf to run a resampling routine and assess the use of multiple CountEm runs to estimate the number of AOTs
7. Results: CV to Inform Number of CountEm Runs: uses the results of the simulation in section 6 to determine if the coefficient of variation (CV) can be used to determine the number of CountEm runs that could be summarised to generate estimates within 5% of the manual count of AOTs
8. Results: Efficiency: uses the data objects df and mdf to summarise the user time required to apply CountEm to generate estimates of the number of AOTs


**(THIS IS AN EXAMPLE)**
**Software Requirements**
Scripts are written for R version 4.2.2 (2022-10-31 ucrt). See scripts and the manuscript for packages and software citations.

Required R packages can be installed in R with:

install.packages(c("tidyverse", 
                   "dplyr", 
                   "data.table",
                   "fossil",
                   "DataCombine",
                   "janitor",
                   "here",
                   "formattable",
                   "openxlsx"]]


**Terms of Use: CC-BY**

You are free to:

**Share** — copy and redistribute the material in any medium or format for any purpose, even commercially.
**Adapt** — remix, transform, and build upon the material for any purpose, even commercially.
The licensor cannot revoke these freedoms as long as you follow the license terms.

Under the following terms:

**Attribution **— You must give appropriate credit, provide a link to the license, and indicate if changes were made . You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.



