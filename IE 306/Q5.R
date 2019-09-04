install.packages("readxl")
library(readxl)
df=read_xlsx("Interarrival_Assignment.xlsx", sheet = "QQ")
plot_data1=df[,c(4,1)]
plot(plot_data1, main="QQ Plot of Day 1 data", xlab="z-scores", ylab="Inter-arrival times")
plot_data2=df[,c(8,5)]
plot(plot_data2, main="QQ Plot of Day 2 data", xlab="z-scores", ylab="Inter-arrival times")

