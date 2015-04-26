setwd('/home/mohamar/datasciencecoursera/exploratory/proj2')
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
library(sqldf)

balt<-subset(NEI,fips=="24510")
motor_vh<-subset(SCC,EI.Sector=="Mobile - On-Road Diesel Heavy Duty Vehicles" |
                   EI.Sector=="Mobile - On-Road Diesel Light Duty Vehicles"|
                   EI.Sector=="Mobile - On-Road Gasoline Heavy Duty Vehicles"|
                   EI.Sector=="Mobile - On-Road Gosoline Light Duty Vehicles"
)
balt_vh<-sqldf("select a.* from balt a where a.SCC in (select distinct SCC from motor_vh)")
balt_vh_gb<-group_by(balt_vh,year)
sum_Em_vh<-summarise(balt_vh_gb,sum(Emissions))
sum_Em_vh$year<-as.factor(sum_Em_vh$year)
plot(sum_Em_vh,
     main="PM2.5 total emissions from motor vehicle in",
     xlab="Year",
     ylab="Total PM2.5 emissions (tons)")
dev.copy(png,"plot5.png",height=700,width=800)
dev.off()