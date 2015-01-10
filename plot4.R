if (!file.exists("./household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./power_data.zip")
        unzip("./power_data.zip", overwrite = T, exdir = ".")
}
tab <- read.table(file ="household_power_consumption.txt", header = TRUE, 
                  na.strings = "?", sep = ";", stringsAsFactors = FALSE)
tab[,1] <- as.Date(tab[,1], format = "%d/%m/%Y")

tab$Datetime <- strptime(paste(tab$Date, tab$Time), "%Y-%m-%d %H:%M:%S")
tabfeb <- tab[tab$Date == as.Date("2007-02-01") | tab$Date == as.Date("2007-02-02"),]

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(x = tabfeb$Datetime, y = tabfeb$Global_active_power, 
     xlab="", ylab = "Global active power (kilowatts)",type = "l")

plot(x = tabfeb$Datetime, y = tabfeb$Voltage, type="l", xlab= "Datetime", ylab = "Voltage")

plot(x = tabfeb$Datetime, y = tabfeb$Sub_metering_1, xlab="", ylab = "Energy sub metering",type = "n")
points(x = tabfeb$Datetime, y = tabfeb$Sub_metering_1,type="l",col="black")
points(x = tabfeb$Datetime, y = tabfeb$Sub_metering_2,type="l",col="red")
points(x = tabfeb$Datetime, y = tabfeb$Sub_metering_3,type="l",col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(x = tabfeb$Datetime, y = tabfeb$Global_reactive_power, type="l", xlab= "Datetime")
dev.off()
