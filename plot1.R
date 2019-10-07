#This script reads "household..." and makes a histogram of the global active power between 2007-02-01 and 2007-02-02

#I store "house_hold..." in data
data <- read.table("household_power_consumption.txt",sep=";",header = TRUE)

#I transform the dates to date format
#I choose tz="CET" because the data where taken in Paris, France (source: https://archive.ics.uci.edu/ml/datasets/individual+household+electric+power+consumption)
data$Date <- strptime(data$Date,format = "%d/%m/%Y",tz="CET")

#I subset the values of data frame with dates between 2007-02-01 and 2007-02-02
data_new <- data[which(data$Date>="2007-02-01 CET" & data$Date<="2007-02-02 CET"),]

#I set the graphic device as png
png(filename = "plot1.png")

#I don't check whether there're "?" values, as the plot function can still work. It just ignores that value. The same applies to the other scripts

#I create the histogram with the corresponding characteristics (color, title, labels, and breaks)
#Note that the default values for the width and height are 480 pixels
#I choose breaks=15 because that's the number of boxes of the shown plot
hist(as.numeric(as.character(data_new$Global_active_power)),col="red",main="Global Active Power",xlab = "Global Active Power (kilowatts)",breaks=15)

#I close the graphic device, so the png is generated
dev.off()