install.packages("readxl")
install.packages("dplyr")
install.packages("gdata")
library("readxl")
library(gdata)
my_data <- read_excel("Assignment2-Interarrival_Data.xls")
day1<- unmatrix(my_data[1],byrow=2)
day2<- unmatrix(my_data[2],byrow=2)
ks.test(day1,"punif",0,400)
ks.test(day2,"punif",0,400)




