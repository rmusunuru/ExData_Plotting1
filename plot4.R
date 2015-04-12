## 
## produces histogram of Global Active Power consumption for households
##
##  
library(sqldf)
library(lubridate)

url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_stat <- file.exists("house.zip")
file_stat <- file.exists("household_power_consumption.txt")
if (!zip_stat) download.file(url1,destfile="house.zip")
if (!file_stat) unzip("house.zip",files = NULL, list=FALSE,overwrite= TRUE, junkpaths = FALSE, 
                      exdir=".")

file1 <- "household_power_consumption.txt"

datar <- read.csv.sql(file1,sql = "select * from file where Date in('1/2/2007','2/2/2007') ", 
                      header=TRUE, sep=";",dbname = tempfile()) 
datar$Datetime <- dmy_hms(paste(datar$Date,datar$Time))
##
## plot the Plot3 to a .png file 
##
png(filename="plot4.png", width=480,height=480)
par(mfcol=c(2,2),mar=c(4,4,2,1))
plot(datar$Datetime,datar$Global_active_power,type ="l",
     xlab="",ylab= "Global Active Power")
plot(datar$Datetime,datar$Sub_metering_1,type ="l",xlab="",
     ylab= "Energy sub metering ", col="black")
lines(datar$Datetime,datar$Sub_metering_2, col = "red")
lines(datar$Datetime,datar$Sub_metering_3, col = "blue")
legend("topright",lty=1, bty="n",col=c("black","red","blue"), 
       legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(datar$Datetime,datar$Voltage,type ="l",xlab="datetime",
          ylab= "Voltage ", col="black")
plot(datar$Datetime,datar$Global_reactive_power,type ="l",xlab="datetime",
          ylab= "Global_reactive_power ", col="black")
dev.off()
