# Cost-Effective Recovery Planning for Threatened Species is Robust to Data Uncertainty

**About this repository**

This repository can be cited as:

_Avery-Gomm, S., Iacona, G., Drew, C. A., Maloney, R., Possingham, H., Rumpff, L., Crouse, D., Newman, J., Rogers, A., Runge, M., & Gerber, L. Year TBD. Cost-effective recovery planning for threatened species is robust to data uncertainty. Figshare. https://doi.org/10.6084/m9.figshare.28578413_

This repository contains all data and code necessary to generate manuscript results associated with the following peer-reviewed publication:

_Avery-Gomm, S., Iacona, G., Drew, C. A., Maloney, R., Possingham, H., Rumpff, L., Crouse, D., Newman, J., Rogers, A., Runge, M., & Gerber, L. Year TBD. Cost-effective recovery planning for threatened species is robust to data uncertainty. Journal TBD. DOI TBD._

**Abstract**

Numerous tools exist to guide cost-effective conservation decisions. A key challenge is ensuring that these tools generate reliable guidance, even when data are highly uncertain. Decision-makers often question whether such tools remain useful when uncertainty is high, but the critical question is whether decision guidance is robust to it. The Project Prioritization Protocol (PPP) is an approach for guiding resource allocation decisions across conservation projects. Based on estimates of the cost, benefit and feasibility of each project, the approach calculates cost-effectiveness, ranks projects and identifies a subset that will deliver the biggest return on investment. Government agencies in Oceania have applied the PPP to endangered species recovery, and a prototype exists in the United States. In this study, we examine how uncertainty in estimates of recovery plan cost, conservation benefit, and probability of success affects the composition of funded portfolios and the expected conservation benefit, using a sensitivity analysis to explore when decision guidance remains robust. Our findings suggest that both remain robust to simulated uncertainty. While these results are specific to this study, the approach is broadly useful. Individuals aiming to use cost-effectiveness analyses for prioritization decisions can address data quality concerns by performing comparable sensitivity analyses.


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


Terms of Use: CC-BY
You are free to:

Share — copy and redistribute the material in any medium or format for any purpose, even commercially.
Adapt — remix, transform, and build upon the material for any purpose, even commercially.
The licensor cannot revoke these freedoms as long as you follow the license terms.

Under the following terms:

Attribution — You must give appropriate credit , provide a link to the license, and indicate if changes were made . You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
This code helps to tackle the question “Are decisions about resource allocation for endangered species management using the PPP robust to data uncertainty, and do they generate useful and sensible decision guidance?” A manuscript on this topic will be submitted in the coming months.

An earlier version of this code supported the 'Uncertainty' element of the published *Resource Allocation Explorer Tool* 
A.I.Drew, S.Avery-Gomm, R.Maloney, L.R.Gerber, Recovery prioritization explorer (2017); https://shiny.sesync.org/apps/RecoveryExplorer/.

Many nations have laws to identify and protect imperiled species and their ecosystems. In the United States, actions taken under the Endangered Species Act (ESA) have prevented many extinctions, but few listed species have recovered to the point where they can have the ESA protections removed. One reason for this is a shortfall in funding, raising a conundrum for agencies responsible for species recovery: Should resources be allocated toward species facing imminent extinction or species whose long-term survival can most benefit from investment? Some argue that the latter strategy is ethically unsound because it may abandon species with little hope of long-term recovery, even when science suggests that the former strategy may miss opportunities to prevent species from ever experiencing the risk of imminent extinction. We suggest that framing recovery prioritization as a resource allocation problem provides a structure to facilitate constructive debate about such important questions. We discuss here the merits of an explicit resource allocation framework and introduce a prototype decision tool that we developed with the U.S. Fish and Wildlife Service (USFWS) to facilitate transparent and efficient recovery allocation decisions.

Further context for this project is available in the Science Policy Forum article: Gerber, L. R., Runge, M. C., Maloney, R. F., Iacona, G. D., Drew, C. A., Avery-Gomm, S., … Zablan, M. A. (2018). Endangered species recovery: A resource allocation problem. Science, 362(6412), 284–286. https://doi.org/10.1126/science.aat8434

This project was funded by SESYNC, and products are attributed to the ESA Decision Making SESYNC working group https://www.sesync.org/news/wed-2017-05-31-1312/a-tool-to-save-species-sesync-science-team-leads-effort-to-increase


