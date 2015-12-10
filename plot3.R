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

## Creates Plot #3 as PNG file: plot3.png
png("plot3.png", width = 800, height = 600)
with(power_consumption, plot(DateTime, Sub_metering_1, type = "line", col = "black", xlab = "", ylab = "Energy Sub Metering"))
with(power_consumption, points(DateTime, Sub_metering_2, type = "line", col = "red"))
with(power_consumption, points(DateTime, Sub_metering_3, type = "line", col = "blue"))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1, cex=1.5)
dev.off()
