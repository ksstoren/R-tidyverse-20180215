# Tidyr

library("readxl")




#        READING DATA FROM DATASETS        #

# From notes
raw_fert <- read_excel(path = "../R-tidyverse-20180216/indicator undata total_fertility.xlsx", sheet = "Data")
raw_fert

raw_infantMort <- read_excel(path = "../R-tidyverse-20180216/indicator gapminder infant_mortality.xlsx", sheet = "Data")
raw_infantMort


# From class
raw_fert <- read_excel("indicator undata total_fertility.xlsx")
raw_infantMort <- read_excel("indicator gapminder infant_mortality.xlsx")







#       RESTRUCTURING DATASET FROM WIDE TO LONG        #



# We want to restructure the data from wide to long (from cross-sec to longitudinal) 
   # Year was the row header of the excel sheet, the key ---- (key = year)
   # All values go into the variable 'fert' --- (value = fert)
   # Country stays the same --- (-country)

raw_fert %>%
  rename(country = `Total fertility rate`) %>%
  gather(key = year, value = fert, -country)

# R thinks that year is text (chr) instead of a numeric (int), which we fix through MUTATE
raw_fert %>%
  rename(country = `Total fertility rate`) %>%
  gather(key = year, value = fert, -country) %>%
  mutate(year = as.integer(year))

#We want to save it as a variable
fert <- raw_fert %>%
  rename(country = `Total fertility rate`) %>%
  gather(key = year, value = fert, -country) %>%
  mutate(year = as.integer(year)) %>%
  mutate(fert = as.integer(fert))






# We now want to do the same for the other dataset


# We want to restructure the data from wide to long (from cross-sec to longitudinal) 
# Year was the row header of the excel sheet, the key ---- (key = year)
# All values go into the variable 'fert' --- (value = fert)
# Country stays the same --- (-country)

raw_infantMort %>%
  rename(country = `Infant mortality rate`) %>%
  gather(key = year, value = infantMort, -country)

# R thinks that year is text (chr) instead of a numeric (int), which we fix through MUTATE
raw_infantMort %>%
  rename(country = `Infant mortality rate`) %>%
  gather(key = year, value = infantMort, -country) %>%
  mutate(year = as.integer(year))

#We want to save it as a variable
infantMort <- raw_infantMort %>%
  rename(country = `Infant mortality rate`) %>%
  gather(key = year, value = infantMort, -country) %>%
  mutate(year = as.integer(year)) %>%
  mutate(infantMort = as.integer(infantMort))





#           JOINING DATASETS           #

gapminder %>%
  left_join(fert, by = c("year", "country")) %>%
  left_join(infantMort, by = c("year", "country"))


# We want to save it as an object 
gapminder_plus <- gapminder %>%
  left_join(fert, by = c("year", "country")) %>%
  left_join(infantMort, by = c("year", "country"))

gapminder_plus






#        producing a file of the dataset            #

write_csv(gapminder_plus, "gapminder_plus.csv")





