#This script reads "household..." and plots the global active power between 2007-02-01 and 2007-02-02
#as a function of time between Thursday at 00:00:00 and Saturday at 00:00:00

#I store "house_hold..." in data
data <- read.table("household_power_consumption.txt",sep=";",header = TRUE)

#I transform the dates to date format
#I choose tz="CET" because the data where taken in Paris, France (source: https://archive.ics.uci.edu/ml/datasets/individual+household+electric+power+consumption)
data$Date <- strptime(data$Date,format = "%d/%m/%Y",tz="CET")

#I subset the values of data frame with dates between 2007-02-01 and 2007-02-02
data_new <- data[which(data$Date>="2007-02-01 CET" & data$Date<="2007-02-02 CET"),]

#I set the graphic device as png
png(filename = "plot2.png")

#I plot the column Global_active_power.
#Notice I don't specify tha values of the x coordinate since I'll set the labels manually as "Thu", "Fri", and "Sat"
plot(as.numeric(as.character(data_new$Global_active_power)),ylab = "Global Active Power (kilowatts)",xlab = "",pch="",xaxt='n')

#I join the points
lines(as.numeric(as.character(data_new$Global_active_power)))

#I set the labels as "Thu" (beginning), "Fri" (middle), and "Sat" (end)
#I didn't make up 1441 and 2881. Times are in minutes and a day has 1440 minutes :)
axis(side = 1, at=c(1,1441,2881),labels=c("Thu","Fri","Sat"))

#I close the graphic device, so the png is generated
dev.off()