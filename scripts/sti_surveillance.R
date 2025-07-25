# If necessary, install the necessary packages
install.packages("tidyverse"); packageVersion("tidyverse") # packageVersion helps you see which version you are running for your analysis
install.packages("janitor"); packageVersion("janitor")
install.packages("viridis"); packageVersion("viridis")

# Load libraries - required at the beginning of every session
library(tidyverse)
library(janitor)
library(viridis)

# read input data
# Table 1 from CDC's Sexually Transmitted Surveillance, 2023. Found here: https://www.cdc.gov/sti-statistics/data-vis/table-sticasesrates.html
# na = c("NR", "-") converts not reported designations from the table to NA
sti_surveillance <- read_csv("data/CDC_STI_Surveillance_2023.csv", na = c("NR", "—"))

# clean up column names with janitor package
sti_surveillance_clean <- sti_surveillance %>% clean_names()

# Compare the column names before and after using the command clean_names
colnames(sti_surveillance)
colnames(sti_surveillance_clean)

# select columns we are interested in 
gc_ct_surveillance <- sti_surveillance %>% select(year, gonorrhea_rate, chlamydia_rate)

# filter to years with both gonorrhea and chlamydia rates
gc_ct_surveillance <- gc_ct_surveillance %>% drop_na()

# some figures require the data to be in the `long` format (rather than the `wide` format that the data is currently in). Change the data structure:
gc_ct_surveillance_long <- gc_ct_surveillance %>%
  rename(Gonorrhea = gonorrhea_rate, Chlamydia = chlamydia_rate) %>%
  pivot_longer(-year, names_to = "STI", values_to = "rate")

# make a figure
plot <- gc_ct_surveillance_long %>%
	ggplot(aes(x=year, y=rate, color=STI)) + # map aesthetics like x variable, y variable, and color variable
	geom_line() + # choose type of vizualization
	theme_minimal() + # set plot theme 
	ylab("Rate (per 100,000 population)") + # change y-axis label
	xlab("") + # remove x-axis label
	scale_color_viridis(discrete = "T", option = "turbo") # set color scale

# view your figure in the plots output pane (bottom right of your window)
plot

# save your figure
ggsave("figures/sti_rates.png", plot, width = 6, height = 3, units = "in") 

