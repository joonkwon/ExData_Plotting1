rm(list=ls())
short <- read.table("household_power_consumption.txt", nrows = 10, sep=";", header=1)
classes <- sapply(short,class)
classes["Date"] <- "character"
classes["Time"] <- "character"
power_con <- read.table("household_power_consumption.txt", 
                        sep=";", header=1, 
                        colClasses = classes, na.strings = "?")
power_con$datetime <- strptime(paste(power_con$Date,power_con$Time), "%d/%m/%Y %H:%M:%S")
power_con <- power_con[,c(10,3,4,5,6,7,8,9)]
power_s <- subset(power_con, (datetime >= '2007-02-01' & datetime < '2007-02-03'))

par(mfcol=c(2,2))

with(power_s, {
    plot(datetime, Global_active_power, type="l", main=NULL, xlab="", 
         ylab="Global Active Power (kilowatts)"
    )  
    plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(datetime, Sub_metering_2, type="l", col="red" )
    lines(power_s$datetime, power_s$Sub_metering_3, type="l", col="blue")
    legend("topright", lty=c(1,1), lwd=c(1,1),col=c("black", "red", "blue"), bty = "n",
           cex=0.7, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
    )
    plot(datetime, Voltage, type="l")
    plot(datetime, Global_reactive_power, type="l")
})

dev.copy(png, file="plot4.png", width = 480, height=480)
dev.off()
