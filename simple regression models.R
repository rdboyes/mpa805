#These lines install addons that you'll need

install.packages('TMB')
install.packages('devtools')
devtools::install_github("strengejacke/strengejacke")
install.packages('tidyverse')
install.packages('corrplot')
install.packages('PerformanceAnalytics')

#These lines enable those addons

library(sjPlot)
library(tidyverse)
library(corrplot)
library(PerformanceAnalytics)
library(scales)

#import the data with the 'import dataset' option on the top right side

#Look at data 

View(kingston_housing)

#Direct Assignment

houses <- kingston_housing

#Subsets (filtering out rows)

houses <- filter(kingston_housing,`Condo?`== 0)
condos <- filter(kingston_housing,`Condo?`== 1)

#Selecting specific columns

houses <- select(houses, -`Condo?`)

#Corr plot
house_corr <- cor(houses)

#make a plot of correlations
corrplot(house_corr, type = "upper", tl.col = "black", tl.srt = 45)

#make a scatter plot of each variable
plot(select(houses,2,`Sale Price`))
plot(select(houses,3,`Sale Price`))
plot(select(houses,4,`Sale Price`))
plot(select(houses,5,`Sale Price`))
plot(select(houses,6,`Sale Price`))

#Nicer plots
ggplot(aes(x = `Sq ft`, y = `Sale Price`), data = houses) + 
  geom_point() +
  geom_smooth() + 
  scale_y_continuous(labels = dollar)

#Combined version
chart.Correlation(houses, histogram=TRUE, pch=19)

#The whole model
model1 <- lm(`Sale Price` ~ Bds + Ba + `Condo?` + Garage + Queens + `Sq ft`,
             data = kingston_housing)

tab_model(model1)

#Only houses

model2 <- lm(`Sale Price` ~ Bds + Ba + `Condo?` + Garage + Queens + `Sq ft`, 
             data = houses)

tab_model(model2)

#Only condos

model3 <- lm(`Sale Price` ~ Bds + Ba + `Condo?` + Garage + Queens + `Sq ft`,
             data = condos)

tab_model(model3)

#Cut model down to best predictors

model4 <- lm(`Sale Price` ~ Ba + `Sq ft`, data = houses)

tab_model(model4)

#look at our two complete models of houses and condos

tab_model(model2,model3)

#look at complete model vs. two predictor model

tab_model(model2, model4)

predictions <- predict(model4, newdata = houses)

#How different are our predictions from the real price? 
ggplot(aes(y = houses$`Sale Price`, x = predictions), data = houses) + 
  geom_point() +
  scale_y_continuous(labels = dollar) +
  scale_x_continuous(labels = dollar) +
  geom_abline(intercept = 0, slope = 1)

