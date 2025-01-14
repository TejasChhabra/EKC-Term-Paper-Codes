rm(list=ls())
library(ggplot2)
library(dplyr)
library(lmtest)
library(olsrr)
library(sandwich)
library(margins)
library(plm) #optional
library(stargazer)
library(lfe)
finalgdpemissionsdata<-read.csv(file.choose())

# finding per capita values for CO2,SO2 and GDP. Using 0.47 to control for price changes over the years and to make results comparable to Holtz Eiken's Results 
finalgdpemissionsdata$co2<-as.numeric(finalgdpemissionsdata$Total.CO2.emissions.from.fossil.fuels.and.cement.production..thousand.metric.tons.of.C.)-as.numeric(finalgdpemissionsdata$Emissions.from.gas.flaring)
finalgdpemissionsdata$co2pc<-as.numeric(finalgdpemissionsdata$co2)/as.numeric(finalgdpemissionsdata$pop)
finalgdpemissionsdata$gdppc<-as.numeric(finalgdpemissionsdata$rgdpe*0.47)/as.numeric(finalgdpemissionsdata$pop)
finalgdpemissionsdata$so2pc<-as.numeric(finalgdpemissionsdata$total_SO2)/as.numeric(finalgdpemissionsdata$pop)

# subsetting over years 
subset1 <- subset(finalgdpemissionsdata,year > 1950 & year < 2018)

# subsetting 2 - subsetting over chosen countries 
subset2 <- subset1 %>%
  filter(Nation == "BANGLADESH" | 
           Nation =="INDIA" | 
           Nation == "THAILAND" | 
           Nation == "MALAYSIA" | 
           Nation == "INDONESIA"| 
           Nation == "NEPAL"| 
           Nation == "PHILIPPINES" | 
           Nation == "CHINA" |
           Nation == "SOUTH KOREA"| 
           Nation == "UNITED ARAB EMIRATES"|
           Nation == "TAIWAN"|
           Nation == "SINGAPORE"| Nation == "JAPAN")


#scatter plot for all countries chosen over CO2
ggplot(data=subset2)+geom_point(aes(x=gdppc, y=co2pc))+ xlab("GDP per capita")+
  ylab("CO2 emissions Per Capita")+ggtitle("Scatter Plot of GDP and CO2")

# Creating a line of best fit to test the inverted U shape for CO2 per capita
ggplot(data=subset2)+geom_smooth(aes(x=gdppc,y=co2pc))+xlab("GDP Per Capita")+
  ylab("CO2 Emissions Per Capita")+ggtitle("Smooth Line of CO2 and GDP")

#scatter plot for all countries chosen over SO2
ggplot(data=subset2)+geom_point(aes(x=gdppc, y=so2pc))+ xlab("GDP per capita")+
  ylab("SO2 emissions Per Cpaita")+ggtitle("Scatter Plot of GDP and SO2")

# Creating a line of best fit to test the inverted U shape for SO2 per capita
ggplot(data=subset2)+geom_smooth(aes(x=gdppc,y=so2pc))+xlab("GDP Per Capita")+
  ylab("SO2 Emissions Per Capita")+ggtitle("Smooth Line of SO2 and GDP")

# Running quadratic regressions and finding the relevant turning points for CO2 and SO2

model1 <- felm(co2pc~gdppc+I(gdppc^2)|Nation + year |0|Nation,subset2)
turningpoint1 <--model1$coefficients[1]/(2*model1$coefficients[2])
print(turningpoint1)
stargazer(model1, type="text")

model2 <- felm(so2pc~gdppc+I(gdppc^2)|Nation + year |0|Nation,subset2)
turningpoint2 <--model2$coefficients[1]/(2*model2$coefficients[2])
print(turningpoint2)
stargazer(model2, type="text")

#Showcasing Results together and publishing them together and separetly 
stargazer(model1,model2, type="text")
stargazer(model1,model2, type="html", out = "regressionsekcfinal.html")
stargazer(model1,type="html", out = "table1.html")
stargazer(model2,type="html", out = "table2.html")
