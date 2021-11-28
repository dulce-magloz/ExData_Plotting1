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
png("plot3.png", width = 480, height = 480)
plot(data$Date_time, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$Date_time, data$Sub_metering_2, type = "l", col = "red")
lines(data$Date_time, data$Sub_metering_3, type = "l", col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid")
dev.off()