## Downloads data
fileurl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('UCI HPC Dataset.zip')){
    download.file(fileurl,'./UCI HPC Dataset.zip', mode = 'wb')
    unzip("UCI HPC Dataset.zip", exdir = getwd())
}

## Loads data into data frames
hpc <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

## Subsets the data
data <- subset(hpc, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Transforms dates
datetime <- paste(data$Date, data$Time)
data$Date_time <- as.POSIXct(datetime)

## Creates the plot, saves the file and closes device
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

## Plot 1,1
plot(data$Date_time, data$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = "")

## Plot 1,2
plot(data$Date_time, data$Voltage, type = "l", 
     ylab = "Voltage", xlab = "datetime")

## Plot 2,1
plot(data$Date_time, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$Date_time, data$Sub_metering_2, type = "l", col = "red")
lines(data$Date_time, data$Sub_metering_3, type = "l", col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid", bty = "n")

## Plot 2,2
plot(data$Date_time, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()