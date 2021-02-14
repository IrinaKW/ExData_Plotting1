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

mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(mydata$Date), mydata$Time)
mydata$Datetime <- as.POSIXct(datetime)

#plot the required graph
with(mydata, plot(mydata$Datetime, mydata$Global_active_power, type='l',
                  ylab='Global Active Power (kilowatts)', xlab=''))


#copy the graph in the png file

dev.copy(png,'plot2.png')
dev.off()
