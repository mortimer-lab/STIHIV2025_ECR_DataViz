# If necessary, install the necessary packages
install.packages("tidyverse"); packageVersion("tidyverse") # packageVersion helps you see which version you are running for your analysis
install.packages("cowplot"); packageVersion("cowplot")

# load libraries
library(tidyverse)
library(cowplot)

# read in input data
# Penicillin susceptibility genotypes and phenotypes from publicly available Neisseria gonorrhoeae data curated as part of Mortimer, Zhang et al. 2022.
metadata_pcn <- read_csv("data/MortimerZhang2022_penicillin_genotypes_phenotypes.csv")
# Tetracycline susceptibility genotypes and phenotypes from publicly available Neisseria gonorrhoeae data curated as part of Mortimer, Zhang et al. 2022.
metadata_tet <- read_csv("data/MortimerZhang2022_tetracycline_genotypes_phenotypes.csv")

# quick look at the data
view(metadata_pcn)
glimpse(metadata_pcn) # Basic information about the data structure
view(metadata_tet)
str(metadata_tet) # Another way to look at your data

# violin plot of penicillin MICs

pcn_plot <- metadata_pcn %>% ggplot(aes(x = fct_relevel(PCN_genotype, "S"), y = PCN, fill = PCN_genotype)) + # set aesthetics including releveling factor so that S, I, R are in the correct order
    geom_violin(bw=0.8, draw_quantiles=c(0.5), trim=FALSE) + # choose plot type and set smoothing bandwidth and quartiles to draw
    theme_bw() + # set theme
    xlab("Genotype") + # set x-axis label
    ylab(expression(paste("PCN MIC (", mu, "g/mL)", ))) + # set y-axis label including using the greek letter mu
    scale_fill_brewer(name = "PCN genotypes", labels = c("penA_01 present \nand blaTEM absent", "penA_01 absent \nor blaTEM present")) + # set colors and specify labels for the legend
    scale_y_continuous(trans = 'log2',  # transform y-axis to a log2 scale
                       limits = c(0.002, 256), # set y-axis limits
                       breaks = c(2^-9, 2^-7, 2^-5, 2^-3, 2^-1, 2^1, 2^3, 2^5, 2^7), # set breaks to show on y-axis
                       labels = c(0.002, 0.008, 0.03, 0.125, 0.5, 2, 8, 32, 128)) + # customize labels for the breaks
    geom_hline(yintercept = 0.06, linetype = "dashed") + # add a horizontal line for the susceptibility cutoff
    geom_hline(yintercept = 2, linetype = "dashed") + # add a horizontal line for the resistance cutoff
    facet_wrap(~dataset) # use facet-wrap to create a plot for each dataset

# view the penicillin plot
pcn_plot

# violin plot of tetracycline MICs

tet_plot <- metadata_tet %>% ggplot(aes(x = fct_relevel(TET_genotype, "S"), y = TET, fill = TET_genotype)) + 
    geom_violin(bw=0.8, draw_quantiles=c(0.5), trim=FALSE) +
    theme_bw() + 
    xlab("Genotype") +
    ylab(expression(paste("TET MIC (", mu, "g/mL)", ))) +
    scale_fill_brewer(palette = "Purples", name = "TET genotypes", labels = c("rpsJ WT\nand tetM absent", "rpsJ V57M\n or tetM present")) +
    scale_y_continuous(trans = 'log2', 
                       limits = c(0.002, 256),
                       breaks = c(2^-9, 2^-7, 2^-5, 2^-3, 2^-1, 2^1, 2^3, 2^5, 2^7), 
                       labels = c(0.002, 0.008, 0.03, 0.125, 0.5, 2, 8, 32, 128)) +
    geom_hline(yintercept = 0.25, linetype = "dashed") +
    geom_hline(yintercept = 2, linetype = "dashed") +
    facet_wrap(~dataset)

# view the tetracycline plot
tet_plot

# plot penicillin and tetracycline plots in A and B panels

p <- plot_grid(pcn_plot, tet_plot, labels = c("A","B"), nrow = 2) 

# view the figure with panels
p

# save to .png file
ggsave("figures/abx_genotype_phenotype.png", p, height = 6, width = 6, units = "in")
