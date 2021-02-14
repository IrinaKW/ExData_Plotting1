#Load libraries
library(gsubfn)

#Download file into the temp location

zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(zip_url, temp, method = "libcurl", mode = "wb")

#Download data from the required text files
#Reading data for only 2 days: 1 Feb 2007 and 2 Feb 2007 (1st column)

myfile<-unzip(zipfile=temp, files='household_power_consumption.txt')
mydata<-read.table(myfile,sep=';', head=TRUE)
mydata<-subset(mydata[grep('^[1-2]/2/2007',mydata$Date),])


#delete temp folder

unlink(temp)

#subset days of the week as factor df

mydata$Global_active_power=as.numeric(mydata$Global_active_power)
mydata$Voltage=as.numeric(mydata$Voltage)
mydata$Global_reactive_power=as.numeric(mydata$Global_reactive_power)

mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(mydata$Date), mydata$Time)
mydata$Datetime <- as.POSIXct(datetime)

#plot the required graph

par(mfrow=c(2,2), mar=c(4,4,2,1))

#plot 1
with(mydata, plot(mydata$Datetime, mydata$Global_active_power, 
                  type='l',
                  xlab='',
                  ylab='Global Active Power (kilowatts)', 
                  cex.lab=0.6, 
                  cex.axis=0.6, 
                  tck=-0.05, 
                  mgp=c(2,0.3,0)))

#plot 2
with(mydata, plot(mydata$Datetime, mydata$Voltage, 
                  type='l',
                  xlab='datetime',
                  ylab='Voltage', 
                  cex.lab=0.6, 
                  cex.axis=0.6, 
                  tck=-0.05, 
                  mgp=c(2,0.3,0)))

#plot3

with(mydata, plot(mydata$Datetime, mydata$Sub_metering_1, 
                  type='l',
                  xlab='', 
                  ylab='Energy sub metering', 
                  cex.lab=0.6, 
                  cex.axis=0.6, 
                  tck=-0.05,
                  mgp=c(2,0.3,0)))
lines(mydata$Datetime, mydata$Sub_metering_2, type='l', col='red')
lines(mydata$Datetime, mydata$Sub_metering_3, type='l', col='blue')
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2",'Sub_metering_3'),
       col=c('black', "red", "blue"), lty=1:3, cex=0.4)

#plot4
with(mydata, plot(mydata$Datetime, mydata$Global_reactive_power, 
                  type='l',
                  xlab='datetime',
                  ylab='Global_reactive_power',
                  cex.lab=0.6, 
                  cex.axis=0.6, 
                  tck=-0.05, 
                  mgp=c(2,0.3,0)))


#copy the graph in the png file

dev.copy(png,'plot4.png')
dev.off()
