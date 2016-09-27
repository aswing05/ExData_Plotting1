#Reading the data

consumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#Cleansing the data(selecting only required data and combining Date and Time variables into a single variable of class POSIXct)

consumption <- consumption[as.Date(consumption$Date, "%d/%m/%Y") == "2007-02-01" | as.Date(consumption$Date, "%d/%m/%Y") == "2007-02-02", ]
consumption$datetime <- paste(consumption$Date, consumption$Time, sep = " ")
consumption$datetime <- strptime(consumption$datetime, "%d/%m/%Y %H:%M:%S")
consumption <- subset(consumption, select=-c(Date, Time))

#Plotting the data

png(filename = "plot1.png", width = 480, height = 480)
hist(consumption$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()
