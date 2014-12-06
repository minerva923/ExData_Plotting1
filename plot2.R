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

with(dt, plot(date.time, Global_active_power, type = "l", xlab = "", 
              ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "./Exploratory Data Analysis/Course Project 1/plot2.png")
dev.off()