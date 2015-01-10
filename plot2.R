if (!file.exists("./household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./power_data.zip")
        unzip("./power_data.zip", overwrite = T, exdir = ".")
}
tab <- read.table(file ="household_power_consumption.txt", header = TRUE, 
                  na.strings = "?", sep = ";", stringsAsFactors = FALSE)
tab[,1] <- as.Date(tab[,1], format = "%d/%m/%Y")

tab$Datetime <- strptime(paste(tab$Date, tab$Time), "%Y-%m-%d %H:%M:%S")
tabfeb <- tab[tab$Date == as.Date("2007-02-01") | tab$Date == as.Date("2007-02-02"),]

png(filename = "plot2.png", width = 480, height = 480)
plot(x = tabfeb$Datetime, y = tabfeb$Global_active_power, 
     xlab="", ylab = "Global active power (kilowatts)",type = "l")
dev.off()