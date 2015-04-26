setwd('/home/mohamar/datasciencecoursera/exploratory/proj2')
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
library(sqldf)

balt_LA<-subset(NEI,fips == "06037" | fips == "24510")

balt_LA<-mutate(balt_LA, 
                ids=ifelse(fips=="06037",'Loss Angeles County','Baltimore City')
)

motor_vh<-subset(SCC,EI.Sector=="Mobile - On-Road Diesel Heavy Duty Vehicles" |
                   EI.Sector=="Mobile - On-Road Diesel Light Duty Vehicles"|
                   EI.Sector=="Mobile - On-Road Gasoline Heavy Duty Vehicles"|
                   EI.Sector=="Mobile - On-Road Gosoline Light Duty Vehicles"
)

balt_LA_vh<-sqldf("select a.* from balt_LA a where a.SCC in (select distinct SCC from motor_vh)")
balt_LA_vh_g<-group_by(balt_LA_vh,ids,year)
sum_Em_balt_LA<-summarise(balt_LA_vh_g,sum(Emissions))
sum_Em_balt_LA$Sum_Em<-sum_Em_balt_LA$"sum(Emissions)"
sum_Em_balt_LA$year<-as.factor(sum_Em_balt_LA$year)
g<-ggplot(sum_Em_balt_LA)+geom_point(aes(x=year,y=Sum_Em,col=year),size=4.5)
k<-g+facet_grid(.~ids)+xlab("Year")+ylab("Emissions of PM2.5 (tons)")
k+labs(title="Total emissions of PM2.5 for motor vehicles in Baltimore City and Los Angeles County")
dev.copy(png,"plot6.png",width=800,height=700)
dev.off()

