setwd('/home/mohamar/datasciencecoursera/exploratory/proj2')
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
library(sqldf)
balt<-subset(NEI,fips=="24510")
year_balt<-group_by(balt,year)
sum_Em_balt<-summarise(year_balt,sum(Emissions))
sum_Em_balt$year<-as.factor(sum_Em_balt$year)
plot(sum_Em_balt,
     xlab="Year",
     ylab="PM2.5 Emissions (tons)",
     main="PM2.5 Total emissions in Baltimore City")
dev.copy(png,"plot2.png",height=700,width=800)
dev.off()
