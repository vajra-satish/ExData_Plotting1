# Load the lubdridate package
library(lubridate)
# Extract the column names 
colnames<-names(read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", nrow=1))
# Read the data file (from row 60000 to row 70000) and use the extracted column names as headers
data<-read.table("./data/household_power_consumption.txt", header=FALSE, col.names = colnames, sep=";", na.strings = "?", skip=60000, nrow=10000)
# Subset the Feb 1 and Feb 2 data
Feb_data<-data[data$Date=="1/2/2007"|data$Date=="2/2/2007", ]
# Combine the Date and Time variable into a single string and store it in the variable datetime
Feb_data$datetime<-with(Feb_data, paste(Date, Time))
# Format the date and time using lubridate
Feb_data$datetime<-with(Feb_data, dmy_hms(datetime))
# Set the mfrow parameter for four row wise plots
par(mfrow=c(2,2))
# Plot the relationship
with(Feb_data, {
        plot(datetime, Global_active_power, xlab="", ylab="Global Active Power", type="l")
        plot(datetime, Voltage, xlab="datetime", ylab="Voltage", type="l")
        plot(datetime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
        points(datetime, Sub_metering_2, col="red", type="l")
        points(datetime, Sub_metering_3, col="blue", type="l")
        legend("topright", lty=1, bty="n", cex=0.7, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(datetime, Global_reactive_power, type="l")
})
# Initiate file graphics device and create an output PNG
dev.copy(png, file = "plot4.png", width=480, height=480)
# Turn off the current graphic device
dev.off()