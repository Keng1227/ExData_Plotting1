fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile=paste0(getwd(),"/Power_consumption.zip"),method = "curl")
unzip("Power_consumption.zip", exdir = "./")
t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
t <- t[complete.cases(t),]
date_time <- paste(t$Date, t$Time)
data <- cbind(date_time, t)
data <- data[, -(2:3)]
data$date_time <- as.POSIXlt(date_time)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# 1
plot(data$date_time, data$Global_active_power,
type="l",
xlab="",
ylab="Global Active Power")
# 2
plot(data$date_time, data$Voltage, type="l",
xlab="datetime", ylab="Voltage")
# 3
plot(data$date_time, data$Sub_metering_1, type="l", col="black",
xlab="", ylab="Energy sub metering")
lines(data$date_time, data$Sub_metering_2, col="red")
lines(data$date_time, data$Sub_metering_3, col="blue")
legend("topright",
col=c("black", "red", "blue"),
c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
lty=1,
box.lwd=0)
# 4
plot(data$date_time, data$Global_reactive_power, type="n",
xlab="datetime", ylab="Global_reactive_power")
lines(data$date_time, data$Global_reactive_power)
dev.copy(png, "plot4.png", width=480, height= 480)
dev.off()
