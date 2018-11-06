install.packages('sjPlot')
library(sjPlot)

#The whole model

model1 <- lm(`Sale Price` ~ Bds + Ba + `Condo?` + Garage + Queens + `Sq ft`, data = kingston_housing)

#Only houses

model2 <- lm(`Sale Price` ~ Bds + Ba + `Condo?` + Garage + Queens + `Sq ft`, data = kingston_housing[kingston_housing$`Condo?` == 0,])

#Only condos

model3 <- lm(`Sale Price` ~ Bds + Ba + `Condo?` + Garage + Queens + `Sq ft`, data = kingston_housing[kingston_housing$`Condo?` == 1,])

#Cut model down to best predictors

model4 <- lm(`Sale Price` ~ Ba + `Sq ft`, data = kingston_housing[kingston_housing$`Condo?` == 0,])

tab_model(model2)

predict(model4, newdata = kingston_housing[kingston_housing$`Condo?` == 1,])
predict(model4, newdata = kingston_housing[kingston_housing$`Condo?` == 0,])
