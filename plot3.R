#Reading the data

consumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#Cleansing the data(selecting only required data and combining Date and Time variables into a single variable of class POSIXct)

consumption <- consumption[as.Date(consumption$Date, "%d/%m/%Y") == "2007-02-01" | as.Date(consumption$Date, "%d/%m/%Y") == "2007-02-02", ]
consumption$datetime <- paste(consumption$Date, consumption$Time, sep = " ")
consumption$datetime <- strptime(consumption$datetime, "%d/%m/%Y %H:%M:%S")
consumption <- subset(consumption, select=-c(Date, Time))

#Plotting the data

png(filename = "plot3.png", width = 480, height = 480)
with(consumption, plot(consumption$datetime, consumption$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(consumption, points(consumption$datetime, consumption$Sub_metering_1, type = "l", col = "black"))
with(consumption, points(consumption$datetime, consumption$Sub_metering_2, type = "l", col = "red"))
with(consumption, points(consumption$datetime, consumption$Sub_metering_3, type = "l", col = "blue"))
with(consumption, legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue")))
dev.off()