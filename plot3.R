setwd("/home/mohamar/datasciencecoursera/exploratory")

data1<-read.table("hpc_elec.txt",header=TRUE,sep=";",na.strings=c("?",""))

data2<-subset(data1,Date=="1/2/2007" | Date=="2/2/2007")

write.table(data2,"selection.txt")

data<-read.table("selection.txt",header=TRUE, 
                 na.strings=c("?",""))
data$Date<-as.character(data$Date)
data$Time<-as.character(paste(data$Date,data$Time,sep=" "))

data$Date<-as.Date(data$Date,"%d/%m/%Y")
data$Time<-strptime(data$Time,"%d/%m/%Y %H:%M:%S")

str(data)
#plot3

with(data,plot(Time,Sub_metering_1,
               type="line", 
               ylab="Energy sub metering", xlab="")
              
     )
with(data,lines(Time,Sub_metering_2,
               type="line", col="red"))
with(data,lines(Time,Sub_metering_3,
                type="line", col="blue"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lwd=c("1","1","1"),
)

