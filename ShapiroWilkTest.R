library(readxl)
library(ggplot2)

#get data
dataset <- read_excel("C:/Users/Anmarie.Flamingo/Desktop/ProductAdoptionDataExport.xlsx")

#Confrim Sample Date Range
min(dataset$Year) #2006
max(dataset$Year) #2016

#make this example reproducible
set.seed(0)

#perform shapiro-wilk test
shapiro.test(dataset$PrescriptionData)

