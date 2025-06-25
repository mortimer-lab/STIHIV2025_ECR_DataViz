# load required libraries
library(tidyverse)
library(cowplot)
library(ggpubr)

# set theme for plots
theme_set(theme_cowplot(font_size=10))

# read data
metadata <- read_csv("data/Mortimer2020_sexualbehavior_AMR.csv")

# define statistical comparisons to show
comparisons.cro <- list(c("MSM", "MSW"), c("MSM", "WSM"), c("MSMW", "WSM"))
comparisons.azi <- list(c("MSMW", "MSW"), c("MSMW", "WSM"), c("MSM", "MSW"), c("MSM", "WSM"))
comparisons.cip <- list(c("MSM", "MSMW"), c("MSM", "MSW"), c("MSM", "WSM"),  c("MSMW", "WSM"))

# plot ceftriaxone MICs by sexual behavior group
partner.cro <- metadata %>%
  ggplot(aes(x = partner, y = ceftriaxone)) + 
  geom_boxplot() + 
  scale_y_continuous(trans='log2',
                     breaks = c(2^(-9), 2^(-7), 2^(-5), 2^(-3), 2^(-1)),
                     labels = c("0.002", "0.008", "0.032", "0.125", "0.5")) + 
  labs(x = "", y = "CRO MIC") + 
  stat_compare_means(comparisons = comparisons.cro, label = "p.signif") +
  stat_compare_means(label.y = 2)

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

# combine plots into a grid
partner.mic <- plot_grid(partner.cro,
                         partner.azi, 
                         partner.cip, 
                         ncol = 1, 
                         align = "v",
                         axis = "tb")

# save plot to .png file
ggsave("figures/sexual_behavior_mic.png", partner.mic, width = 4, height = 9, units = "in")
