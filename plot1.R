# Download the data file
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("data")){dir.create("data")}
download.file(fileURL, destfile = "./data/electric_consumption.zip", method="curl")
unzip("./data/electric_consumption.zip", exdir="./data/")
# Extract the column headers
colnames<-names(read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", nrow=1))
# Read the data frame. For efficiency in terms of memory usage, read only specified row numbers.
data<-read.table("./data/household_power_consumption.txt", header=FALSE, col.names = colnames, sep=";", na.strings="?", skip=60000, nrow=10000)
# Subset the February 1 and February 2 data
Feb_data<-data[(data$Date=="1/2/2007"|data$Date=="2/2/2007"), ]
# Plot the Histogram
hist(Feb_data$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red", main="Global Active Power")
# Initiate file graphics device and create an output PNG
dev.copy(png, width=480, height=480, file="plot1.png")
# Turn off the current graphic device
dev.off()
