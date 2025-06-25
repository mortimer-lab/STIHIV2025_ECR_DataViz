library(tidyverse)
library(janitor)
library(viridis)

# read input data
sti_surveillance <- read_csv("data/CDC_STI_Surveillance_2023.csv", na = c("NR", "—"))

# clean up column names with janitor package
sti_surveillance <- sti_surveillance %>% clean_names()

# select columns we are interested in 
gc_ct_surveillance <- sti_surveillance %>% select(year, gonorrhea_rate, chlamydia_rate)

# filter to years with both gonorrhea and chlamydia rates

gc_ct_surveillance <- gc_ct_surveillance %>% drop_na()

gc_ct_surveillance_long <- gc_ct_surveillance %>%
  rename(Gonorrhea = gonorrhea_rate, Chlamydia = chlamydia_rate) %>%
  pivot_longer(-year, names_to = "STI", values_to = "rate")

plot <- gc_ct_surveillance_long %>%
	ggplot(aes(x=year, y=rate, color=STI)) +
	geom_line() + 
	theme_minimal() +
	ylab("Rate (per 100,000 population)") +
	xlab("") +
	scale_color_viridis(discrete = "T", option = "turbo")

ggsave("figures/sti_rates.png", plot, width = 6, height = 3, units = "in") 

