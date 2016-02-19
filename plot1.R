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

hist(power_s$Global_active_power, 
     col="red", 
     main="Glabal Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency"
)