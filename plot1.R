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
## plot the Plot1 to a .png file 
##
  png(filename="plot1.png", width=480,height=480)
  hist(datar$Global_active_power,col = "red", main="Global Active Power",
       xlab= "Global Active Power(kilowatts)")
  dev.off()
  