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
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)" , main = "Global Active Power", col = "red")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
