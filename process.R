library(data.table)
file <- "./Exploratory Data Analysis/Course Project 1/household_power_consumption.txt"
header <- fread(file, nrows = 1, header = FALSE)
colClasses <- c(rep("character", 2), rep("numeric", 7))
dt <- fread(file, sep=";", na.strings = c("?", ""), skip = "1/2/2007", 
            nrows = 20000, colClasses = colClasses, data.table = FALSE)
## fault occurs in row 36319, which I can't solve it, so using nrows to avoid
setnames(dt, as.character(header[1,]))
dt <- subset(dt, dt$Date == "1/2/2007" | dt$Date == "2/2/2007")
dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
date.time <- paste(dt$Date, dt$Time, sep=" ")
date.time <- strptime(date.time, format = "%Y-%m-%d %H:%M:%S")
dt <- cbind(date.time, dt)


## plot 1
hist(dt$Global_active_power, main = "Global Active Power", breaks = 11
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.copy(png, file = "./Exploratory Data Analysis/Course Project 1/plot1.png")
dev.off()

## plot 2
with(dt, plot(date.time, Global_active_power, type = "l", xlab = "", 
              ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "./Exploratory Data Analysis/Course Project 1/plot2.png")
dev.off()

## plot 3
with(dt, plot(date.time, y = Sub_metering_1, type = "l", xlab = "", 
              ylab = "Energy sub metering"))
with(dt, lines(date.time, Sub_metering_2, type="l", col = "red"))
with(dt, lines(date.time, Sub_metering_3, type="l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty=c(1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "./Exploratory Data Analysis/Course Project 1/plot3.png")
dev.off()

## plot 4
par(mfcol = c(2, 2))
with(dt, plot(date.time, Global_active_power, type = "l", xlab = "", 
              ylab = "Global Active Power (kilowatts)"))
with(dt, plot(date.time, y = Sub_metering_1, type = "l", xlab = "", 
              ylab = "Energy sub metering"))
with(dt, lines(date.time, Sub_metering_2, type="l", col = "red"))
with(dt, lines(date.time, Sub_metering_3, type="l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty=c(1,1), bty = "n", cex=0.7,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(dt, plot(date.time, Voltage, type = "l", xlab = "datetime", 
              ylab = "Voltage"))
with(dt, plot(date.time, Global_reactive_power, type = "l", xlab = "datetime", 
              ylab = "Global_reactive_power"))
dev.copy(png, file = "./Exploratory Data Analysis/Course Project 1/plot4.png", 
         width=480, height=480)
dev.off()