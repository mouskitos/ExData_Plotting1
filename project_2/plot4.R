setwd('/home/mohamar/datasciencecoursera/exploratory/proj2')
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
library(sqldf)

coal<-subset(SCC,SCC.Level.Four=="Coal")
us_coal<-sqldf("select b.* from NEI b where b.SCC in (select distinct a.SCC from coal a)")
us_coal_g<-group_by(us_coal, year)
sum_Em_coal<-summarise(us_coal_g,sum(Emissions))
sum_Em_coal$year<-as.factor(sum_Em_coal$year)

plot(sum_Em_coal,
     main="Total PM2.5 emissions of coal combustion across the US",
     xlab="Year",
     ylab="PM2.5 emissions (tons)"
)

dev.copy(png,"plot4.png",height=700,width=800)
dev.off()
