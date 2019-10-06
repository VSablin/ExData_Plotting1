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
png(filename = "plot3.png")

#I generate a plot jsut with Sub_metering_1.
#Notice I don't specify tha values of the x coordinate since I'll set the labels manually as "Thu", "Fri", and "Sat"
plot(as.numeric(as.character(data_new$Sub_metering_1)),xlab="",ylab = "Energy sub metering",xaxt="n",pch="")

#I join the points
lines(as.numeric(as.character(data_new$Sub_metering_1)),col="black")

#I add Sub_metering_2 and Sub_metering_3
lines(as.numeric(as.character(data_new$Sub_metering_2)),col="red")
lines(as.numeric(as.character(data_new$Sub_metering_3)),col="blue")

#I set the labels as "Thu" (beginning), "Fri" (middle), and "Sat" (end)
#I didn't make up 1441 and 2881. Times are in minutes and a day has 1440 minutes :)
axis(side = 1, at=c(1,1441,2881),labels=c("Thu","Fri","Sat"))

#I set the legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

#I close the graphic device, so the png is generated
dev.off()