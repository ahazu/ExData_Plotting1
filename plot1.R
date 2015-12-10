## Loads required libraries
library(sqldf)
library(lubridate)

## Downloads dataset if not available in the current folder
if(!file.exists("exdata-data-household_power_consumption.zip") && !file.exists("household_power_consumption.txt")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "exdata-data-household_power_consumption.zip")
    dateDownloaded <- date()
    
    unzip("exdata-data-household_power_consumption.zip")
    
}

## Reads data for 1/2/2007 and 2/2/2007 from file
power_consumption <- read.csv.sql("household_power_consumption.txt", sql = "select * from file WHERE Date IN ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

## Creates new DateTime column and converts to date
power_consumption$DateTime <- paste(power_consumption$Date, power_consumption$Time)
power_consumption$DateTime <- dmy_hms(power_consumption$DateTime)


## Produces histogram over Global Active Power and creates png file: plot1.png
png("plot1.png", width = 800, height = 600)
with(power_consumption, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

## Copies histogram to PNG file: plot1.png
dev.off()