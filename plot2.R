# Load the lubdridate package
library(lubridate)
# Extract the column names 
colnames<-names(read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", nrow=1))
# Read the data file (from row 60000 to row 70000) and use the extracted column names as headers
data<-read.table("./data/household_power_consumption.txt", header=FALSE, sep=";", col.names=colnames, na.strings = "?", skip=60000, nrow=10000)
# Subset the Feb 1 and Feb 2 data
Feb_data<-data[data$Date=="1/2/2007"|data$Date=="2/2/2007", ]
# Combine the Date and Time variable into a single string and store it in the variable datetime
Feb_data$datetime<-with(Feb_data, paste(Date, Time))
# Format the date and time using lubridate
Feb_data$datetime<-dmy_hms(Feb_data$datetime)
#  Check the class of the datetime variable
with(Feb_data, class(datetime))
# Initiate file graphic device
png(filename="plot2.png", width=480, height=480)
# Plot the figure in the file device
with(Feb_data, plot(datetime, Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l"))
# Turn off the current graphic device
dev.off()
