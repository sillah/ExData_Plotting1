# create the working dir if it doesn't exist
if (!file.exists("ExData_Plotting1")){
    dir.create("ExData_Plotting1")
}

# Set the working dir
setwd("./ExData_Plotting1")

# Enter the url and download the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "hh_power_consumption.zip")
dateDownloaded <- date()

# unzip the file
unzip ("hh_power_consumption.zip")

# load the file
Lines <- readLines("household_power_consumption.txt")

# Find the lines for only 2007-02-01 and 2007-02-02
subL <- grep("[1-2]/2/2007", substr(Lines, 1,8))

# Read data for only 2007-02-01 and 2007-02-02 and load them into a table
powerData <- read.table(text=Lines[subL], header = FALSE, sep=";")

# Add names to the table
names(powerData) = c("Date", "Time", "Global_active_power", 
                     "Global_reactive_power", "Voltage", "Global_intensity", 
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Create Plot3
# Open the png file device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

plot(strptime(paste(as.Date(powerData$Date,"%d/%m/%Y"),powerData$Time),
              "%Y-%m-%d %H:%M:%S"),  powerData$Sub_metering_1, type="l", 
     col="black",xlab="", ylab="Energy sub metering",lwd=1.5)
lines(strptime(paste(as.Date(powerData$Date,"%d/%m/%Y"),powerData$Time),
               "%Y-%m-%d %H:%M:%S"),  powerData$Sub_metering_2, type="l", 
      col="red",lwd=1.5)
lines(strptime(paste(as.Date(powerData$Date,"%d/%m/%Y"),powerData$Time),
               "%Y-%m-%d %H:%M:%S"),  powerData$Sub_metering_3, type="l", 
      col="blue",lwd=1.5)
legend("topright",lwd=1.5, lty=c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
title(xlab="", ylab="Energy sub metering")

# Close the png file device
dev.off()