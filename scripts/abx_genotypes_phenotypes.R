library(tidyverse)
library(cowplot)

# read in input data
metadata_pcn <- read_csv("data/MortimerZhang2022_penicillin_genotypes_phenotypes.csv")
metadata_tet <- read_csv("data/MortimerZhang2022_tetracycline_genotypes_phenotypes.csv")

# violin plot of penicillin MICs

pcn_plot <- metadata_pcn %>% ggplot(aes(x = fct_relevel(PCN_genotype, "S"), y = PCN, fill = PCN_genotype)) +
    geom_violin(bw=0.8, draw_quantiles=c(0.5), trim=FALSE) +
    theme_bw() + 
    xlab("Genotype") +
    ylab(expression(paste("PCN MIC (", mu, "g/mL)", ))) +
    scale_fill_brewer(name = "PCN genotypes", labels = c("penA_01 present \nand blaTEM absent", "penA_01 absent \nor blaTEM present")) +
    scale_y_continuous(trans = 'log2', 
                       limits = c(0.002, 256),
                       breaks = c(2^-9, 2^-7, 2^-5, 2^-3, 2^-1, 2^1, 2^3, 2^5, 2^7), 
                       labels = c(0.002, 0.008, 0.03, 0.125, 0.5, 2, 8, 32, 128)) +
    geom_hline(yintercept = 0.06, linetype = "dashed") +
    geom_hline(yintercept = 2, linetype = "dashed") +
    facet_wrap(~dataset)


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

# plot penicillin and tetracycline plots in A and B panels

p <- plot_grid(pcn_plot, tet_plot, labels = c("A","B"), nrow = 2) 

# save to .png file

ggsave("figures/abx_genotype_phenotype.png", p, height = 6, width = 6, units = "in")
