#==============================================================================#
# Course Title: Data Vizualisation Workshop
# Date: 30th July 2025
#==============================================================================#

# loading all the required libraries
library(dplyr)
library(janitor)
library(stringi)
library(ggplot2)

#==============================================================================#
# load data
data_01_Africa <- read.csv("data/African_meningococci.csv")
#==============================================================================#
# 1. get to know the structure of your data
str(data_01_Africa)

# OR

glimpse(data_01_Africa)

#==============================================================================#
# 2. view the column names
names(data_01_Africa)

# OR

colnames(data_01_Africa)

#==============================================================================#
# 3. tidy up column names. 
data_02_Africa <- clean_names(data_01_Africa)

# confirm that the names of the columns have changed
names(data_01_Africa)
names(data_02_Africa)

#==============================================================================#
# 4. To view the first top rows - by default will view 6
data_03_Africa <- head(data_01_Africa, 10)


#==============================================================================#
# 5. To view the bottom rows - by default will view the last 6
data_04_Africa <- tail(data_01_Africa)

#==============================================================================#
# 6. Selecting columns
data_01_subset <- select(data_01_Africa, id, isolate, country)

# OR (remove certain columns)

data_02_subset <- select(data_01_Africa, -id, -isolate)

#==============================================================================#
# 7. Filtering rows

Nigeria <- filter(data_01_Africa, country == "Nigeria")

TOGO <- filter(data_01_Africa, country == "Togo")
#==============================================================================#
# 8. Number of samples in each country
table(data_01_Africa$country)

#==============================================================================#
# remove all the data frames loaded except the data_01_Africa
rm(data_02_Africa, data_03_Africa, data_04_Africa, Nigeria, data_01_subset, data_02_subset)

#==============================================================================#
# 9. clean names
data_02_Africa <- data_01_Africa %>%
  clean_names()

#==============================================================================#
# 10. clean names and select columns
data_02_Africa <- data_01_Africa %>%
  clean_names()  %>%
  select(id, isolate, year, country)

#==============================================================================#
# 11. clean names | select columns | Filter only "Burkina Faso"
data_02_Africa <- data_01_Africa %>%
  clean_names()  %>%
  select(id, isolate, year, country) %>%
  filter(country == "Burkina Faso")

#==============================================================================#
# 12. Number of samples identified per year per Country, 'group-by' function
data_03_Africa <- data_01_Africa %>%
  clean_names() %>%
  group_by(country, year) %>%
  summarise(n()) %>%
  rename(count = 'n()') # to rename your third column from "n()" to "count"

#==============================================================================#
# 13. Number of samples identified in each year per Country
data_04_Africa <- data_01_Africa %>%
  clean_names() %>%
  group_by(serogroup, country) %>%
  summarise(count = n()) %>%
  mutate(prop = count/sum(count) *100)

#==============================================================================#
# 14. Table showing the number of each serogroup by year and country
data_05_Africa <- data_01_Africa %>%
  clean_names() %>%
  group_by(country, year, serogroup) %>%
  summarise(count = n()) %>%
  mutate(prop = count/sum(count) *100)

#==============================================================================#
# 15. Visualize with points on a graph
# We use the function ggplot, which is under ggplot2 package
library(ggplot2) # already loaded in line 11
plot_Africa <- data_05_Africa %>%
  ggplot(aes(x = year, y = country)) +
  geom_point(aes(color = serogroup, size = count), alpha = 6) +
  xlab("Year") +
  ylab("Country") +
  theme_minimal() +
  theme(axis.title = element_text(size = 35),
        axis.text = element_text(size = 35),
        legend.text = element_text(size = 14),       # Increase legend text size
        legend.title = element_text(size = 16),      # Increase legend title size
        legend.key.size = unit(1.5, "lines")) +
  guides(color = "none")

