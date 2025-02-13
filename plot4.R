df <- read.delim("household_power_consumption.txt", sep = ";")
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$datetime <- paste(df$Date, df$Time)
df$datetime <- strptime(df$datetime, format = "%Y-%m-%d %H:%M:%S")
library("rio")
library("dplyr")
df1 <- subset(df, df$datetime >= strptime("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S") & df$datetime <= strptime("2007-02-02 24:00:00", format = "%Y-%m-%d %H:%M:%S"))
png(filename="plot4.png", width=480, height=480)
par(mfrow= c(2, 2))
plot(df1$datetime, as.numeric(df1$Global_active_power), xlab = "", ylab="Global Active Power (kilowatts)", type ="l")
plot(df1$datetime, df1$Voltage, xlab="datetime", ylab="Voltage", type="l")
plot(df1$datetime, df1$Sub_metering_1, type ="l", col ="black", xlab = "", ylab = "Energy sub metering")
lines(df1$datetime, df1$Sub_metering_2, type ="l", col ="red")
lines(df1$datetime, df1$Sub_metering_3, type ="l", col ="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(df1$datetime, as.numeric(df1$Global_reactive_power), xlab="datetime", ylab="Global_reactive_power", type="l")
dev.off()