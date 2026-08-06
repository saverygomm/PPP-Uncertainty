## About this Repository

This repository can be cited as:


Avery-Gomm, S., Iacona, G., Drew, C. A., Maloney, R., Possingham, H., Rumpff, L., Rogers, A., Gerber, L. & Runge, M. 2026. Data and code supporting _"How robust are conservation prioritization decisions to data uncertainty? A case study using the Project Prioritization Protocol."_ Figshare. https://doi.org/10.6084/m9.figshare.28578413

This repository contains all data and code necessary to generate manuscript results associated with the following peer-reviewed publication:

Avery-Gomm, S., Iacona, G., Drew, C. A., Maloney, R., Possingham, H., Rumpff, L., Rogers, A., Gerber, L. & Runge, M. TBD. _How robust are conservation prioritization decisions to data uncertainty? A case study using the Project Prioritization Protocol._ TBD. https://doi.org/TBD
 
## Description
This study examines how uncertainty in estimates of recovery plan cost, conservation benefit, and probability of success influences the composition of funded portfolios and the expected conservation benefit. Through a sensitivity analysis, we identify scenarios where decision guidance remains robust despite data uncertainty.

## Code

The code required to reproduce the ppp analysis is located in /ppp_project/final_script.R and relies on input files stored in /ppp_project/data/. The script is well-commented and structured into the following sections:

### 1) Set the Working Directory

Before running the analysis, set the working directory to the **ppp_project** folder. Use the following command, replacing `"path/to/ppp_project"` with the actual location on your system:

```r
setwd("path/to/ppp_project")
```

### 2) Installation

Ensure that all necessary R packages are installed by running the following command:

```r
install.packages(c("magrittr", "DT", "ggplot2", "plotly", "tidyverse","scales","reshape2", "simpleboot", "cowplot", "simpleboot", "boot"))
```

### 3) Import and Process Species Plan Data for Analysis

#### Datasets Used  
The following datasets, located in the **data/** directory, serve as inputs for the analysis:  

- **AllPPPOutput.csv**: Final output from the PPP analysis, providing cost estimates at the **Recovery Plan** level (identified by `unique_plan_num`).  

- **draft_b.csv**: An intermediate dataset generated prior to **Data2.csv** in the `GenerateBenefits.R` function of the PPP analysis. `data_b` indicates which `sp_vip_codes` were included in the analysis and links benefit data from the species-level **RPN** file.  

- **RPNs-for-plan_id-and-sp_vip_code-combos-NAs-imputed.csv**: The *first* intermediate dataset produced by `RPN_Benefit_Success_Taxonomy3.R`, containing necessary data on **B** and **B_with_without_Mgmt** at the `sp_vip_code` level.  

- **sim_df.chosen.csv**: A dataset with selected variance parameters for cost, benefit, and success variables.  

- **sim_df_baseline.csv**: A dataset containing budget parameters.  

#### Processed Dataset  
During preprocessing, non-essential variables are removed from each dataset. The following columns are retained in the **dataSpp** dataset, located in **ppp_project/output/**:  

- **sp_vip_code**: Unique species identification code.  
- **unique_plan_num**: Unique identifier for each conservation plan.  
- **RPN_Benefit**: Conservation benefit from intervention/management (continuous variable: 0–1).  
- **RPN_TaxoWeighting**: Taxonomic uniqueness score (continuous variable: 0.33–1, with higher values indicating greater rarity).  
- **taxanomic_group**: Taxonomic classification of the species.  
- **rpn**: USFWS prioritization classification (lower values indicate higher priority); the `"C"` modifier denotes candidate species for ESA listing.  
- **threat_status**: ESA threat status classification.  
- **RPN_noC**: RPN classification excluding the `"C"` modifier.  
- **Conflict**: Binary variable (0 or 1), indicating whether conservation efforts may cause social or economic disruptions.  
- **USFWS_RPN_Available**: Binary variable (0 or 1), indicating whether RPN data is available.  
- **RPN_TaxoWeighting_char**: Taxonomic weighting category (`"Subspecies"`, `"Species"`, `"Monotypic_genus"`, `"NA"`).  
- **RPN_Degree_of_Threat**: Threat level classification (`"Moderate"`, `"High"`, `"Low"`, `"NA"`).  
- **RPN_Recoverability_Potential**: Recoverability classification (`"High"`, `"Low"`, `"NA"`).  
- **Benefit_with_Mgmt**: Species benefit from conservation intervention (continuous variable: 0–1, with 1 indicating the greatest benefit).  
- **Benefit_without_Mgmt**: Species conservation status improvement without intervention (continuous variable: 0–1, with 1 indicating the greatest benefit).  
- **sp_vip_code_in_plan_id**: Number of species included in the same conservation plan.  
- **unique_id**: Unique identifier for the recovery plan.  
- **plan_title**: Name of the recovery plan.  
- **SpeciesInPlan**: Number of species covered by the plan (range: 1–66).  
- **Responsible_region**: USFWS regional classification (1–8) [see details here](https://www.fws.gov/about/regions).  
- **taxa_code_text**: Taxonomic classification (`"Mammals"`, `"Flowering Plants"`, `"Birds"`, `"Insects"`, `"Snails"`, `"Crustaceans"`, `"Amphibians"`, `"Fishes"`, `"Lichens"`, `"Clams"`, `"Reptiles"`, `"Arachnids"`, `"Ferns and Allies"`, `"Conifers and Cycads"`).  
- **plan_CE**: Cost-efficiency metric of the conservation plan.  
- **plan_B**: Conservation impact of the plan (continuous variable: 0.001–40.59).  
- **plan_W**: Taxonomic uniqueness score (continuous variable: 0.33–1, with higher values indicating greater rarity).  
- **S**: Probability of plan success (continuous variable: 0.5–0.88).  
- **Co**: Total 50-year cost of conservation management (continuous variable: $1,973–$20,395,753,569).  
- **B_without_Mgmt**: Species conservation status improvement without intervention (continuous variable: 0–1).  
- **B_with_Mgmt**: Species benefit with conservation intervention (continuous variable: 0–1).  
- **B**: Net benefit of management (continuous variable: 0.12–0.88, calculated as **Benefit_with_Mgmt - Benefit_without_Mgmt**). 

For a detailed breakdown of how these datasets are processed and combined, refer to **final_script.RMD**.  

### 4) Results

The following dataframes contain the results of the analysis and, after running the code, can be located in the **ppp_project/output/** directory.

Data uncertainty was simulated with respect to **costs (C)**, **benefits (B)**, and **probability of success (S)** in different combinations to assess the impact of uncertainty in each scenario. These included:

- **BSCo_**: Variance applied to *benefit, success, and cost*.
- **BS_**: Variance applied to *benefit and success*.
- **BCo_**: Variance applied to *benefit and cost*.
- **SCo_**: Variance applied to *success and cost*.
- **S_**: Variance applied to *success* only.
- **Co_**: Variance applied to *cost* only.
- **B_**: Variance applied to *benefit* only.

For each of the above combinations, four output dataframes are generated and saved in the output folder (example below uses `B` as the placeholder, but all combinations are included in the analysis):

- **B_output.csv**: Contains data on the mean number of species funded per plan and variance about that mean with added uncertainty. It also includes the mean conservation benefits per plan and variance around that estimate.

- **B_probfund.csv**: For each combination of added variance (low, medium, high) introduced to the target variable(s), this dataframe captures the average number of times the species plan was selected for inclusion under the specified budget, indicating its probability of being included.

- **B_probfund_results.csv**: Based on the probability of inclusion scores from `B_probfund.csv`, plans are classified into three categories:
  - Always included: 100% probability of inclusion.
  - Sometimes included: Between 0% and 100% probability of inclusion.
  - Never included: 0% probability of inclusion.
  This dataframe summarizes the number of plans categorized under each variance scenario. 
- **one.of.the.datasim.B.csv**: For each variance scenario, 100 simulations are run to introduce uncertainty into the targeted parameter. The efficiency of each plan is ranked accordingly, and the most efficient plans are included in the final portfolio until the budget threshold is met. A datasim placeholder is created for each iteration, and a sample datasim is exported as a CSV file for reference.

These output files allow for an in-depth assessment of how uncertainty in costs, benefits, and success probabilities influences conservation planning decisions under different budget constraints.

### 5) Tables and Figures

This section of code generates the following figures, which can be found in the **/ppp_project/output/** directory:

- **ppp_figure_1.pdf**: Bar plots depicting the proportion of plans categorized as *always*, *sometimes*, and *never* included across different uncertainty and budget scenarios.  
- **ppp_figure_2.pdf**: Visualization of the probability of recovery plan inclusion in a funded portfolio under high uncertainty.  
- **ppp_figure_3.pdf**: Illustration of the fraction of recovery plans in each decision category as a function of inclusion thresholds.  
- **ppp_figure_4.pdf**: Depiction of variation in conservation benefit under simulated uncertainty, applied separately to benefits, probability of success, and costs.  

### 6) Example of Variance in Benefits, Success, and Cost  

The following tables illustrate how variance is introduced to the **Cost**, **Benefit**, and **Success** parameters under low, medium, and high uncertainty levels:  

- **sim_beta.csv**: Contains variance parameters used to simulate uncertainty in benefit and success variables, drawn from a beta distribution.  
- **sim_norm.csv**: Contains variance parameters used to simulate uncertainty in cost variables, drawn from a normal distribution.  


## Dependencies  
This project requires the following R packages:

- magrittr
- DT
- ggplot2
- plotly
- tidyverse
- scales
- reshape2
- simpleboot
- cowplot
- simpleboot
- boot

## File Structure

```r
/ppp_project
│── README.docx
│── data/                # Raw data files
│── output/              # Plots and tables generated for the analysis
│── functions/           # Functions used for the analysis
│── ppp_script.R         # Main script
```

## Terms of Use: CC-BY-40

You are free to:

- **Share** — copy and redistribute the material in any medium or format for any purpose, even commercially.
- **Adapt** — remix, transform, and build upon the material for any purpose, even commercially.

Under the following terms:
- **Attribution** You must give appropriate credit, provide a link to the license, and indicate if changes were made . You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.


