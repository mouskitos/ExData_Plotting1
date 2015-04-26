setwd('/home/mohamar/datasciencecoursera/exploratory/proj2')
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
library(sqldf)
year_<-group_by(NEI,year)
sum_Em<-summarise(year_,sum(Emissions))
sum_Em$year<-as.factor(sum_Em$year)
plot(sum_Em,
     main="Total PM2.5 emission from all sources",
     xlab="Year",
     ylab="PM2.5 emissions (tons)")

dev.copy(png,'plot1.png',height=700,width=800)
dev.off()

