#Course 4 February 2016
# Project 1
library(data.table)
setwd("/Users/Murali/Documents/Coursera/Course 4/Week 1")
#path=getwd()
# downloading data zip file - already done
# listing all files in the zip folder
unzip("exdata-data-household_power_consumption.zip",list=T)

memory.size()
# first time you read table without sep and header you just get 1 column with all variables joined by ;
# initially all dates, time and other variables read as factors
# instructions say missing values coded as ?
elec_power=read.table(unzip("exdata-data-household_power_consumption.zip"),sep=";",header=T,na.strings="?",stringsAsFactors=FALSE)
dim(elec_power)
names(elec_power)
head(elec_power)

str(elec_power)
# Date and time show up as character "16/12/2006", "17:24:00"
#instructions to just pull records corresponding to dates of 2007-02-01 or 2007-02-02

strDates <- as.Date(c("2007-02-01", "2007-02-02"))
class(strDates)
strDates
sub_EP <- elec_power[as.Date(elec_power$Date, format="%d/%m/%Y") %in% strDates, ]
head(sub_EP)
dim(sub_EP)
tail(sub_EP)
str(sub_EP)

# 2,880 rows and 9 columns in sub_EP data frame
# Date and Time are character

library(lubridate)

sub_EP$DateTime <- strptime(paste(sub_EP$Date, sub_EP$Time), format="%d/%m/%Y %H:%M:%S")
str(sub_EP$DateTime)

# Plot 3

# First plot Sub_metering_1 as usual
# Then annotate using lines for Sub_metering_2, Sub_metering_3 respectively
plot(sub_EP$DateTime,sub_EP$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(sub_EP$DateTime,sub_EP$Sub_metering_2,type="l",col="red")
lines(sub_EP$DateTime,sub_EP$Sub_metering_3,type="l",col="blue")
 
legend("topright",
       lty=c(1,1,1), 
       col=c("black","red","blue"),cex=0.5,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,file="Plot3.png")
dev.off()



