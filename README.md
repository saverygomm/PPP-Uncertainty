## About this Repository

This repository can be cited as:

> Avery-Gomm, S., Iacona, G., Drew, C. A., Maloney, R., Possingham, H., Rumpff, L., Rogers, A., Gerber, L. & Runge, M. 2026. Data and code supporting _"How robust are conservation prioritization decisions to data uncertainty? A case study using the Project Prioritization Protocol."_ Figshare. https://doi.org/10.6084/m9.figshare.28578413

This repository contains all data and code necessary to generate manuscript results associated with the following peer-reviewed publication:

> Avery-Gomm, S., Iacona, G., Drew, C. A., Maloney, R., Possingham, H., Rumpff, L., Rogers, A., Gerber, L. & Runge, M. (TBD). _How robust are conservation prioritization decisions to data uncertainty? A case study using the Project Prioritization Protocol._ TBD. https://doi.org/TBD
 
## Description

This study examines how simulated uncertainty in estimates of recovery plan cost, conservation benefit, and probability of success influences the composition of funded portfolios and the expected conservation benefit. Through a sensitivity analysis, we identify scenarios where decision guidance remains robust despite data uncertainty.

 ## Quick Start

   1. Clone or download this repository
   2. Ensure you have the correct version of R.
   3. Unzip packages folder.
   Ensure all datasets in **data/** are present
   4. Open `final_script.Rmd` in RStudio
   5. Click **Knit** (or run chunks sequentially)
   6. Results will be saved to **output/** (this will overwrite contents)
  
 ## Code

The code required to reproduce the PPP analysis is `final_script.Rmd` and relies on input files stored in **data/**. The script is well-commented and structured as described below.


### Prerequisites

- **R version**: 4.4.0 (or compatible)
- **Required packages**: Install before running:

```r
install.packages(c("magrittr", "DT", "ggplot2", "plotly", "tidyverse", "scales", 
                   "reshape2", "simpleboot", "cowplot", "boot", "rmarkdown"))
```

### Custom Functions

The analysis requires a custom beta distribution function located in **functions/**:

- **rBeta.R**: Custom function for generating random values from a beta distribution with specified parameters.


### 1) Import and Process Species Plan Data for Analysis

#### Input Datasets  

The following datasets, located in **data/**, serve as inputs for the analysis:  

- **AllPPPOutput.csv**: Final output from the [Gerber et al., 2018](https://www.science.org/doi/10.1126/science.aat8434) PPP analysis, providing cost estimates at the recovery plan level (identified by `unique_plan_num`).  

- **draft_b.csv**: An intermediate dataset generated prior to **Data2.csv** in the `GenerateBenefits.R` function. Indicates which `sp_vip_codes` were included in the analysis and links benefit data from the species-level RPN file.  

- **RPNs-for-plan_id-and-sp_vip_code-combos-NAs-imputed.csv**: The first intermediate dataset produced by `RPN_Benefit_Success_Taxonomy3.R`, containing benefit and management-weighted benefit data at the `sp_vip_code` level.  

- **sim_df.chosen.csv**: Selected variance parameters for cost, benefit, and success variables.  

- **sim_df_baseline.csv**: Budget parameters for sensitivity analyses.

- **sim_beta.csv**: Variance parameters for beta distribution (benefit and success variables).

- **sim_norm.csv**: Variance parameters for normal distribution (cost variables).


#### Processed Dataset Output

After preprocessing (via `final_script.Rmd`), the **dataSpp** dataset is saved to **output/** with the following columns, organized by scope:

##### Species-Level Variables

- **sp_vip_code**: Unique species identification code.
- **RPN_Benefit**: Conservation benefit from intervention/management (0–1).
- **RPN_TaxoWeighting**: Taxonomic uniqueness score (0.33–1, higher = greater rarity).
- **RPN_Degree_of_Threat**: Threat level classification (`"Moderate"`, `"High"`, `"Low"`, `"NA"`).
- **RPN_Recoverability_Potential**: Recoverability classification (`"High"`, `"Low"`, `"NA"`).
- **Benefit_with_Mgmt**: Species benefit from conservation intervention (0–1).
- **Benefit_without_Mgmt**: Species conservation status without intervention (0–1).
- **RPN_TaxoWeighting_char**: Taxonomic weighting category (`"Subspecies"`, `"Species"`, `"Monotypic_genus"`, `"NA"`).

##### Plan-Level Variables

- **unique_plan_num**: Unique identifier for each conservation plan.
- **unique_id**: Unique identifier for the recovery plan.
- **plan_title**: Name of the recovery plan.
- **SpeciesInPlan**: Number of species covered by the plan (1–66).
- **sp_vip_code_in_plan_id**: Number of species included in the same conservation plan.
- **plan_CE**: Cost-efficiency metric of the conservation plan.
- **plan_B**: Conservation impact of the plan (0.001–40.59).
- **plan_W**: Taxonomic uniqueness score (0.33–1, higher = greater rarity).
- **S**: Probability of plan success (0.5–0.88).
- **Co**: Total 50-year cost of conservation management ($1,973–$20,395,753,569).
- **B**: Net benefit of management (0.12–0.88), calculated as **Benefit_with_Mgmt - Benefit_without_Mgmt**.
- **B_without_Mgmt**: Species conservation status without intervention (0–1).
- **B_with_Mgmt**: Species benefit with conservation intervention (0–1).

##### Metadata Variables

- **taxonomic_group**: Taxonomic classification of the species.
- **taxa_code_text**: Taxonomic group (`"Mammals"`, `"Birds"`, `"Flowering Plants"`, `"Insects"`, `"Fishes"`, `"Amphibians"`, `"Reptiles"`, `"Snails"`, `"Crustaceans"`, `"Clams"`, `"Arachnids"`, `"Lichens"`, `"Ferns and Allies"`, `"Conifers and Cycads"`).
- **rpn**: USFWS prioritization classification (lower = higher priority). The `"C"` modifier denotes candidate species for ESA listing.
- **RPN_noC**: RPN classification excluding the `"C"` modifier.
- **threat_status**: ESA threat status classification.
- **Conflict**: Binary indicator (0 or 1) of whether conservation efforts may cause social or economic disruptions.
- **USFWS_RPN_Available**: Binary indicator (0 or 1) of whether RPN data is available.
- **Responsible_region**: [USFWS regional classification](https://www.fws.gov/about/regions) (1–8).

For a detailed breakdown of how these datasets are processed and combined, see `final_script.Rmd`.

### 2) Uncertainty Scenarios

Data uncertainty is simulated across different parameter combinations:

| Scenario | Parameters affected |
|----------|-------------------|
| **BSCo** | Benefit, success, and cost |
| **BS** | Benefit and success |
| **BCo** | Benefit and cost |
| **SCo** | Success and cost |
| **B** | Benefit only |
| **S** | Success only |
| **Co** | Cost only |
| **Baseline** | No uncertainty |

### 3) Output Files

For each scenario, four dataframes are generated in **output/**:

- **{Scenario}_output.csv**: Mean number of species funded and conservation benefits with standard deviations.
- **{Scenario}_probfund.csv**: Probability of plan inclusion across variance levels.
- **{Scenario}_probfund_results.csv**: Plans classified as *always*, *sometimes*, or *never* included.
- **one.of.the.datasim.{Scenario}.csv**: Example output from a single simulation iteration.

### 4) Figures and Tables

Generated outputs saved to **output/** include:

- **ppp_figure_1.pdf**: Proportion of plans in each inclusion category across uncertainty and budget scenarios.  
- **ppp_figure_2.pdf**: Probability of recovery plan inclusion under high uncertainty.  
- **ppp_figure_3.pdf**: Plans by decision category across different inclusion thresholds.  
- **ppp_figure_4.pdf**: Variation in conservation benefit under different uncertainty sources.  


## Terms of Use: CC-BY-4.0

You are free to:

- **Share** — copy and redistribute the material in any medium or format for any purpose, even commercially.
- **Adapt** — remix, transform, and build upon the material for any purpose, even commercially.

Under these terms:
- **Attribution** — provide appropriate credit, a link to the license, and indicate if changes were made. You may do so in any reasonable manner without suggesting the licensor endorses your use.

Now data/ and output/ are consistent throughout—bolded, with trailing slash, no leading slash.





# TO DO BEFORE PUBLISHING

#### Column List Verification

**Note:** The detailed column lists above (Species-Level Variables (sp_vip_code, RPN_Benefit, RPN_TaxoWeighting, etc.)
Plan-Level Variables (unique_plan_num, SpeciesInPlan, Co, B, S, etc.) Metadata Variables (taxonomic_group, taxa_code_text, rpn, threat_status, etc.)) reflects the expected structure of **dataSpp** based on the preprocessing logic in `final_script.Rmd`. To verify this matches your actual output, run the preprocessing chunks and inspect the dataset:

```r
str(dataSpp)
colnames(dataSpp)
head(dataSpp)
```

If the column names or structure differ, update the README and the script comments accordingly. Pay particular attention to any species-level or plan-level variables that may have been dropped during the merging or filtering steps (lines 143–187 of the script).
