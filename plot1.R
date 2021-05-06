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

## PLOT 1 : histogram of Global Active Power (in red)
png(filename="plot1.png")
hist(prepped$Global_active_power, col="red", main="Global Active Power", dexlab="Global Active Power (kilowatts)")
dev.off()
