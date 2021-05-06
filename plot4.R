library(dplyr)
library(lubridate)

dir <- "/Desktop/RStuff/ExData_Plotting1"
setwd(dir)

exdata <- read.table(file="./data/exdata_data_household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", nrows=70000)

exdata$Time <- strptime(exdata$Date, format="%d/%m/%Y")
exdata$Time <- format(exdata$Time, "%m/%d/%Y")

prepped <- subset(exdata, Time %in% c("02/01/2007","02/02/2007"))
prepped$Global_active_power <- as.numeric(prepped$Global_active_power)
prepped$Global_reactive_power <- as.numeric(prepped$Global_reactive_power)
prepped$Voltage <- as.numeric(prepped$Voltage)
prepped$Global_intensity <- as.numeric(prepped$Global_intensity)
prepped$Sub_metering_1 <- as.numeric(prepped$Sub_metering_1)
prepped$Sub_metering_2 <- as.numeric(prepped$Sub_metering_2)

## get day of week for graph
prepped$Day <- wday(as.Date(prepped$Date, "%d/%m/%Y"), label=TRUE)

## PLOT 4.png : 2x2 of plots (2,3 in col 1)
png(filename = "plot4.png", width = 480, height = 480,
    units = "px")
par(mfcol=c(2,2))

##Plot 4a:
plot(prepped$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", xaxt="n", type="l")
axis(side=1, at=c(0,1440,2880), labels=c("Thu","Fri","Sat"))

##Plot 4b:
plot(prepped$Sub_metering_1, ylab="Energy sub metering", xlab="", xaxt="n", type="l")
lines(prepped$Sub_metering_2, type="l", col="red")
lines(prepped$Sub_metering_3, type="l", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c("black","red","blue"))

## Plot 4c: Voltage
plot(prepped$Voltage, ylab="Voltage", xlab="datetime", xaxt="n", type="l")
axis(side=1, at=c(0,1440,2880), labels=c("Thu","Fri","Sat"))

## Plot 4d:
plot(prepped$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", xaxt="n", type="l")
axis(side=1, at=c(0,1440,2880), labels=c("Thu","Fri","Sat"))

dev.off()