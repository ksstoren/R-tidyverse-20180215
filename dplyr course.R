# Pipe
# %>%

# Function SELECT: We are only interested in the countries
gapminder %>% select(country)

# Function SELECT: We can include several variables
gapminder %>% select(country, year, gdpPercap)

# Function SELECt to remove variable
gapminder %>% select(-gdpPercap)


# Function SELECT: We want to select variables AND create a new objct in our environment
year_country_gdp <- gapminder %>% 
  select(year, country, gdpPercap)


# Function FILTER to chose data from one year and make a plot
gapminder %>%
  filter(year == 2002) %>%
  ggplot(mapping = aes(x = continent, y = pop))+
  geom_boxplot()


# Combine functions FILTER and SELECT - NB do filter first!
gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)


# Challenge 1
# Dataset for Norwegian values for gdpPercap, lifeExp and year
gapminder %>% 
  filter(country == "Norway") %>%
  select (gdpPercap, lifeExp, year)



# Function GROUP BY
gapminder %>%
  group_by(continent)


# Compbining functions GROUP BY and SUMMARIZE
gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))






# Challenge 2

# Average life expectancy per country in asia + find lowest and highest by PLOTTING
gapminder %>%
  filter(continent == "Asia") %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp)) %>%
  ggplot(mapping = aes(x=country, y=mean_lifeExp))+
  geom_point()

# OR find lowest and highest by filtering again
gapminder %>%
  filter(continent == "Asia") %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp)) %>%
  filter(mean_lifeExp == min(mean_lifeExp) | 
           mean_lifeExp == max(mean_lifeExp))




# Grouping of several variables
gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))


# We can include more steps in summarize command
gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop))


# Function MUTATE to add new coloumns based on existing coloumns
gapminder %>%
  mutate(gdp_billion = gdpPercap * pop / 10^9)



# Challenge 3
# Average life expectancy and GDP in billions in 1987 for each continent
gapminder %>%
  filter(year == "1987") %>%
  group_by(continent) %>%
  mutate(gdp_billion = gdpPercap * pop / 10^9) %>%
  summarize(mean_lifeExp = mean(lifeExp), mean_gdp_billion = mean(gdp_billion))


gapminder_country_summary <- gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp))








#            MAPS             #


map_data("world") %>%
  rename(country = region) %>%
  left_join(gapminder_country_summary, by = "country") %>%
  ggplot() +
  geom_polygon(mapping = aes(x = long, y = lat, group =  group, fill = mean_lifeExp))

#US is gray because the US in maps and our dataset is named differently




# HOMEWORK -- repeating world map, but with fert instead of lifeExp
mean_fert <- gapminder_plus %>%
  group_by(country) %>%
  summarize(mean_fert = mean(fert))
map_data("world") %>%
  rename(country = region) %>%
  left_join(mean_fert, by = "country") %>%
  ggplot() +
  geom_polygon(mapping = aes(x = long, y = lat, group =  group, fill = mean_fert))





# LUKAS TRIES TO SOLVE THE GRAY COUNTRIES #

library(countrycode)

lukasTest <- mean_fert
lukasTest$country[lukasTest$country == "United States"] <- "USA"
lukasTest$country[lukasTest$country == "United Kingdom"] <- "UK"

#lukasTest$countryCode = lukasTest$country
#lukasTest$countryCode = countrycode(lukasTest$countryCode, 'country.name', 'iso3c')
#lukasTest$countryCode = iso.expand(lukasTest$countryCode)
map_data("world") %>%
  rename(country = region) %>%
  left_join(lukasTest, by = "country") %>%
  ggplot() +
  geom_polygon(mapping = aes(x = long, y = lat, group =  group, fill = mean_fert))

