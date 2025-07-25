# If necessary, install the necessary packages
install.packages("tidyverse"); packageVersion("tidyverse") # packageVersion helps you see which version you are running for your analysis
install.packages("cowplot"); packageVersion("cowplot")
install.packages("ggpubr"); packageVersion("ggpubr")

# load required libraries
library(tidyverse)
library(cowplot)
library(ggpubr)

# set theme for plots
theme_set(theme_cowplot(font_size=10)) # rather than setting the theme within the plot, we can set the theme for all plots created by a script

# read data
# Sexual behavior and antimicrobial susceptibility metadata associated with N. gonorrhoeae isolates collected in New York City as part of Mortimer et al. 2020.
metadata <- read_csv("data/Mortimer2020_sexualbehavior_AMR.csv")

# define statistical comparisons to show
comparisons.cro <- list(c("MSM", "MSW"), c("MSM", "WSM"), c("MSMW", "WSM"))
comparisons.azi <- list(c("MSMW", "MSW"), c("MSMW", "WSM"), c("MSM", "MSW"), c("MSM", "WSM"))
comparisons.cip <- list(c("MSM", "MSMW"), c("MSM", "MSW"), c("MSM", "WSM"),  c("MSMW", "WSM"))

# plot ceftriaxone MICs by sexual behavior group
partner.cro <- metadata %>%
  ggplot(aes(x = partner, y = ceftriaxone)) +  # define plot aesthetics
  geom_boxplot() +  # choose plot type
  scale_y_continuous(trans='log2', # change scale to log2-transformed scale
                     breaks = c(2^(-9), 2^(-7), 2^(-5), 2^(-3), 2^(-1)), # identify specific breaks to show on the y-axis
                     labels = c("0.002", "0.008", "0.032", "0.125", "0.5")) +  # define custom labels for those breaks
  labs(x = "", y = "CRO MIC") +  # update x and y axis labels
  stat_compare_means(comparisons = comparisons.cro, label = "p.signif") + # use ggpubr function to compare means between x-axis groups using wilcoxon test (default)
  stat_compare_means(label.y = 2) # add Kruskal-Wallis p-value and specify position

# view figure
partner.cro

# plot azithromycin MICs by sexual behavior group
partner.azi <- metadata %>%
  ggplot(aes(x = partner, y = azithromycin)) + 
  geom_boxplot() + 
  scale_y_continuous(trans='log2',
                     breaks = c(2^(-7), 2^(-5), 2^(-3), 2^(-1), 2, 2^3, 2^5, 2^7),
                     labels = c("0.008", "0.032", "0.125", "0.5", "2", "8", "32", "128")) +
  labs(x = "", y = "AZM MIC") +
  stat_compare_means(comparisons = comparisons.azi, label = "p.signif") +
  stat_compare_means(label.y =15)

# view figure
partner.azi

# plot ciprofloxacin MICs by sexual behavior group
partner.cip <- metadata %>%
  ggplot(aes(x = partner, y = ciprofloxacin)) + 
  geom_boxplot() + 
  scale_y_continuous(trans='log2',
                     breaks = c(2^(-9), 2^(-7), 2^(-5), 2^(-3), 2^(-1), 2, 2^3, 2^5),
                     labels = c("0.002", "0.008", "0.032", "0.125", "0.5", "2", "8", "32")) +
  labs(x = "Sex of Sex Partner", y = "CIP MIC") +
  stat_compare_means(comparisons = comparisons.cip, label = "p.signif") +
  stat_compare_means(label.y = 15)

# view figure
partner.cip

# combine plots into a grid
partner.mic <- plot_grid(partner.cro,
                         partner.azi, 
                         partner.cip, 
                         ncol = 1, 
                         align = "v",
                         axis = "tb")

# view combined figure in the plot output pane
partner.mic

# save plot to .png file
ggsave("figures/sexual_behavior_mic.png", partner.mic, width = 4, height = 9, units = "in")
