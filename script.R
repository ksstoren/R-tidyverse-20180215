#' ---
#' title: "R tidyverse workshop"
#' author: "`Carpentry@UiO`"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---




#     WRAP-UP     #
# We conclude this lesson by reiterating our ggplot2 data visualization template.

`ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>), stat = <STAT>) +
  <SCALE_FUNCTION> +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION> + 
  <LABS>`





#' *Read more about this type of document in 
#' [Chapter 20 of "Happy Git with R"](http://happygitwithr.com/r-test-drive.html)*
#'  
#' Uncomment the following lines to install necessary packages

#install.packages("tidyverse")
#install.packages("maps")
#install.packages("gapminder")

#' First we need to load libraries installed previously
library(tidyverse)
library(maps)
library(gapminder)

#' We will source `gapminder` dataset into the session and assign it 
#' to the variable with the same name
gapminder <- gapminder::gapminder

gapminder

#' Let's make our first plot
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))


#' Let's learn some more about `ggplot2` and its functions!


#' Generally speaking ggplot2 syntax follows the template:
# ggplot(<DATA>) +
#   geom_<GEOM_FUNCTION>(mapping=aes(<AESTETICS>))



# ggplots connects with +
# ggplot (-dataset-) +
#   geom_point(-where we want the variables- = aes(x=-variable-, y=-variable-))


#' Let's make our second plot
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=year))

#we want to swap variables
ggplot(gapminder)+
  geom_point(mapping = aes(y=gdpPercap, x=year))

#now we want to fix the overflooding, that so many points land on top of each other
ggplot(gapminder)+
  geom_jitter(mapping = aes(y=gdpPercap, x=year))

#going back to life expectancy
ggplot(gapminder)+
  geom_jitter(mapping = aes(y=gdpPercap, x=lifeExp))

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=gdpPercap, y=lifeExp))

#Adding onother variable as color
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=gdpPercap, y=lifeExp, color=continent))

#Plotting population growth
ggplot(gapminder)+
  geom_jitter(mapping = aes(y=pop, x=gdpPercap, color=continent))

#other variables
ggplot(gapminder)+
  geom_jitter(mapping = aes(y=lifeExp, x=year, color=continent))


# switch continent and year
ggplot(gapminder)+
  geom_jitter(mapping = aes(y=lifeExp, x=continent, color=year))

# switch year with country
ggplot(gapminder)+
  geom_jitter(mapping = aes(y=lifeExp, x=continent, color=country))
#  this is not functional - number of colors must be limited to be possible to interpret



#changing the very first plot color = time
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=gdpPercap, y=lifeExp, color=year))

# counteracting overflooding
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=log(gdpPercap), y=lifeExp, color=year))


# change year to continent
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=log(gdpPercap), y=lifeExp, color=continent))

# adding another dimension, size
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=log(gdpPercap), y=lifeExp, color=continent, 
                            size=pop))


# Challenge 3: five dimension in the same graph - aestethics

# Adding shape as aestethic
ggplot(gapminder)+
  geom_jitter(mapping = aes(x=log(gdpPercap), y=lifeExp, color=year, 
                            size=pop, shape=continent))



#' Let's go back to our first plot - now adding aestethics differently, outside aes
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp), color="blue")

ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp), color="blue", alpha=0.1)

# These functions can be used to correspond to specific data or all points in 
# total, depending on whether it is placed within or outside the aes parentheses


# new geom function LIES
ggplot(gapminder)+
  geom_line(mapping = aes(x=year, y=lifeExp, color=continent))


# add group to group points to form lines
ggplot(gapminder)+
  geom_line(mapping = aes(x=year, y=lifeExp, 
                          group=country, 
                          color=continent))

# doing the same for boxplots
ggplot(gapminder)+
  geom_boxplot(mapping = aes(x=continent, y=lifeExp, 
                          color=continent))

# layering several plots - first plots gets plotted underneath the next ones
ggplot(gapminder)+
  geom_jitter(mapping=aes(x=continent, y=lifeExp, color=continent))+
  geom_boxplot(mapping = aes(x=continent, y=lifeExp, color=continent))
  


# simplifying
ggplot(gapminder, mapping=aes(x=continent, y=lifeExp, color=continent))+
  geom_jitter()+
  geom_boxplot()


# adding new layer to a previous plot, a regression line
ggplot(gapminder, mapping = aes(x=log(gdpPercap), y=lifeExp, color=continent))+
  geom_jitter()+
  geom_smooth()

# forcing linear lines
ggplot(gapminder, mapping = aes(x=log(gdpPercap), y=lifeExp, color=continent))+
  geom_jitter()+
  geom_smooth(method="lm")






# Challenge 5

#create a single regression line for all data points
# done by moving color to jitter layer - then the line does not know about the continents
ggplot(gapminder, mapping = aes(x=log(gdpPercap), y=lifeExp))+
  geom_jitter(mapping = aes(color=continent))+
  geom_smooth(method="lm")

# OR done by adding color black to smooth layer
ggplot(gapminder, mapping = aes(x=log(gdpPercap), y=lifeExp, color=continent))+
  geom_jitter()+
  geom_smooth(method="lm", color="black")



# Change the log scale to make the graph easier to interpret
ggplot(gapminder, mapping = aes(x=gdpPercap, y=lifeExp, color=continent))+
  geom_point()+
  geom_smooth(method="lm")+
  scale_x_log10()


# Challenge 6

# Boxlot of life expectancy by year - NB we than have to add group!
ggplot(gapminder)+
  geom_boxplot(mapping = aes(x=year, y=lifeExp, group=year))

# Same but for gdpPercap
ggplot(gapminder, mapping = aes(x=year, y=gdpPercap, group=year))+
  geom_boxplot()+
  scale_y_log10()


# make a histogram
ggplot(gapminder)+
  geom_histogram(mapping = aes(x=gdpPercap), bins = 20)+
  scale_x_log10()


#Density function
ggplot(gapminder)+
  geom_density(mapping = aes(x=gdpPercap, color=continent))+
  scale_x_log10()


#Density2d - two dimensional
ggplot(gapminder)+
  geom_density2d(mapping = aes(x=gdpPercap, y=lifeExp))+
  scale_x_log10()


#     FACETING     #

#going back to our first plot
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))+
  facet_wrap(~continent)

ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))+
  facet_wrap(~country)

ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))+
  facet_wrap(~year)



# Challenge 7 - let's not go there





#     COORDINATE SYSTES     # - let's not go there








#       LABELING CHARTS     #



ggplot(gapminder)+
  geom_point(mapping=aes(x=gdpPercap, y=lifeExp, color=continent, size=pop))+
  scale_x_log10()+
  labs(x="GDP per capita in 'ooo USD", y="life expectancy at birth, years",
       color="continent",
       size="population",
       title="GDP per capita vs Life expectancy",
       subtitle="the more money you have the longer you'll live",
       caption="Source: GAPMINDER.ORG foundation")+

# even more fancy
ggplot(gapminder)+
  geom_point(mapping=aes(x=gdpPercap, y=lifeExp, color=continent, size=pop))+
  scale_x_log10()+
  labs(x="GDP per capita in 'ooo USD", y="life expectancy at birth, years",
       color="continent",
       size="population",
       title="GDP per capita vs Life expectancy",
       subtitle="the more money you have the longer you'll live",
       caption="Source: GAPMINDER.ORG foundation")+
  facet_wrap(~year)
ggsave("pyplot.png")







#     WRAP-UP     #



# We conclude this lesson by reiterating our ggplot2 data visualization template.

`ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>), stat = <STAT>) +
  <SCALE_FUNCTION> +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION> + 
  <LABS>`





Suggestion to how you do an animation:
  
#  https://plot.ly/ggplot2/animations/
  
  #Necessary packages:   
  install.package("plotly")
library(plotly)

#Makes tth plots:
p <-ggplot(gapminder)+
  geom_point(mapping=aes(x=gdpPercap,y=lifeExp,color=continent, size=pop, frame=year))+
  scale_x_log10()+
  labs(x="GDP per capita in '000 USD",
       y="Life expectancy at birth, years",
       color="Continent",
       size="Population",
       title="How the world goes to hell",
       subtitle="People live to long and eat to much",
       caption="This is something weired from the GAPMINER.ORG foundation")

#Converts the plots into an animation       
p<-ggplotly(p)

#Runs the animation
p