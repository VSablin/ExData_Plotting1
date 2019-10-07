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
png(filename = "plot4.png")

#I generate a 2x2 lattice of plots. I also set the margins so that there's enough space for the plots and such that each plot is rectangular (similar to that in the assignment)
par(mfrow=c(2,2),mar=c(4,4,5,2))

#I generate the Global_active_power plot (which is actually plot2.png)
#Notice I don't specify tha values of the x coordinate since I'll set the labels manually as "Thu", "Fri", and "Sat"
plot(as.numeric(as.character(data_new$Global_active_power)),ylab = "Global Active Power",xlab = "",pch="",xaxt='n')
#I join the points
lines(as.numeric(as.character(data_new$Global_active_power)))
#I set the labels as "Thu" (beginning), "Fri" (middle), and "Sat" (end)
#I didn't make up 1441 and 2881. Times are in minutes and a day has 1440 minutes :)
axis(side = 1, at=c(1,1441,2881),labels=c("Thu","Fri","Sat"))

#Voltage plot.
plot(as.numeric(as.character(data_new$Voltage)),ylab = "Voltage",xlab = "datetime",pch="",xaxt='n')
#Joining the points
lines(as.numeric(as.character(data_new$Voltage)))
axis(side = 1, at=c(1,1441,2881),labels=c("Thu","Fri","Sat"))

#Sub_metering_n plot (plot3.png)
#I initialize a plot with Sub_metering_1
plot(as.numeric(as.character(data_new$Sub_metering_1)),xlab="",ylab = "Energy sub metering",xaxt="n",pch="")
#Joining the points
lines(as.numeric(as.character(data_new$Sub_metering_1)),col="black")
#I incorporate sub_metering_2,sub_metering_3
lines(as.numeric(as.character(data_new$Sub_metering_2)),col="red")
lines(as.numeric(as.character(data_new$Sub_metering_3)),col="blue")
axis(side = 1, at=c(1,1441,2881),labels=c("Thu","Fri","Sat"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty="n")

#Global_reactive_power plot
plot(as.numeric(as.character(data_new$Global_reactive_power)),ylab = "Global_reactive_power",xlab = "datetime",pch="",xaxt='n')
#Joining the points
lines(as.numeric(as.character(data_new$Global_reactive_power)))
axis(side = 1, at=c(1,1441,2881),labels=c("Thu","Fri","Sat"))

#I close the graphic device, so the png is generated
dev.off()