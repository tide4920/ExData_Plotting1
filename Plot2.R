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

#Plot 2
library(lubridate)

sub_EP$DateTime <- strptime(paste(sub_EP$Date, sub_EP$Time), format="%d/%m/%Y %H:%M:%S")
str(sub_EP$DateTime)

table(sub_EP$Global_active_power)
summary(sub_EP$Global_active_power)

plot(sub_EP$DateTime, sub_EP$Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png, file="Plot2.png")
dev.off()



