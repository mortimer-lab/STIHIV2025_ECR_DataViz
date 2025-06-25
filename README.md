# STIHIV2025_ECR_DataViz
Resources for the Data Visualization Workshop at STI HIV 2025

## Software Requirements

This workshop requires [R](https://cran.rstudio.com/) (version >= 4.2). We also recommend [RStudio](https://posit.co/download/rstudio-desktop/).

Additionally, vizualizations will use the following R packages:
- [tidyverse](https://www.tidyverse.org/)
- [cowplot](https://cran.r-project.org/web/packages/cowplot/index.html)
- [ggpubr](https://cran.r-project.org/web/packages/ggpubr/index.html)

## data
Input data to use during workshop activities

### CDC_STI_Surveillance_2023.csv
Table 1 from CDC's *Sexually Transmitted Surveillance, 2023*. The original table can be found here: [Table 1. Sexually Transmitted Infections — Reported Cases and Rates of Reported Cases*, United States](https://www.cdc.gov/sti-statistics/data-vis/table-sticasesrates.html)

### Mortimer2020_sexualbehavior_AMR.csv
Sexual behavior and antimicrobial susceptibility metadata associated with *N. gonorrhoeae* isolates collected in New York City as part of [Mortimer et al. 2020](https://academic.oup.com/cid/article/73/9/e3146/5896040). This data was used to generate Figure 2C.

### MortimerZhang2022_penicillin_genotypes_phenotypes.csv
Penicillin susceptibility genotypes and phenotypes from publicly available *Neisseria gonorrhoeae* data curated as part of [Mortimer, Zhang et al. 2022](https://www.thelancet.com/journals/lanmic/article/PIIS2666-5247(22)00034-9/fulltext). This data was used to generate Figure 1A.

### MortimerZhang2022_tetracycline_genotypes_phenotypes.csv
Tetracycline susceptibility genotypes and phenotypes from publicly available *Neisseria gonorrhoeae* data curated as part of [Mortimer, Zhang et al. 2022](https://www.thelancet.com/journals/lanmic/article/PIIS2666-5247(22)00034-9/fulltext). This data was used to generate Figure 1B.

## figures
Directory containing example output for the data and scripts in this repository

### abx_genotype_phenotype.png
Example figure created by `abx_genotype_phenotype.R`.

### sexual_behavior_mic.png
Example figure created by `sexual_behavior_MIC.R`.

### sti_rates.png
Example figure created by `sti_surveillance.R`.

## scripts
Directory containing example scripts to visualize the data in this repository

### abx_genotype_phenotype.R
Script to recreate Figure 1 from [Mortimer, Zhang et al. 2022](https://www.thelancet.com/journals/lanmic/article/PIIS2666-5247(22)00034-9/fulltext).

### sexual_behavior_MIC.R
Script to recreate Figure 2C from [Mortimer et al. 2020](https://academic.oup.com/cid/article/73/9/e3146/5896040).

### sti_surveillance.R
Script to plot chlamydia and gonorrhea rates from CDC surveillance data.
