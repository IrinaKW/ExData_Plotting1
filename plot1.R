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

#plot the required graph
mydata$Global_active_power=as.numeric(mydata$Global_active_power)
hist(mydata$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')

#copy the graph in the png file

dev.copy(png,'plot1.png')
dev.off()
