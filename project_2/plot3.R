setwd('/home/mohamar/datasciencecoursera/exploratory/proj2')
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
library(sqldf)
type_year_balt<-group_by(balt,type,year)
sum_Em_type<-summarise(type_year_balt,sum(Emissions))
sum_Em_type$Sum_Em<-sum_Em_type$"sum(Emissions)"
sum_Em_type$year<-as.factor(sum_Em_type$year)
g<-ggplot(sum_Em_type) 
k<-g + geom_point(aes(x=year,y=Sum_Em,col=year),size=4.5) + facet_grid(.~type)
k+labs(title="Total emissions of the four sources type in Baltimore City",
       x="Year",
       y="PM2.5 emissions (tons)"
       )
dev.copy(png,"plot3.png",height=700,width=800)
dev.off()
