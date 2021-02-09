# Coursera - JHU Exploratory Data Analysis - Week 1 - Project Course

# Packages
library(dplyr)
library(lubridate)

# Import data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset_zipped <- "temp"
dataset_unzipped <- "./data/household_power_consumption.txt"

if (!file.exists(dataset_unzipped|dataset_zipped)){
            fileURL
            download.file(fileURL, dataset_zipped, method="curl")
}  
if (!file.exists("temp")) { 
            unzip(zipfile = dataset_zipped, exdir = "./data/") 
}

# Delete compressed file
if (file.exists("temp")) {
            file.remove(dataset_zipped)
}

# Delete temp env.
remove("dataset_unzipped","dataset_zipped", "fileURL")

# get dataset
UCI_HCP <- read.csv2("./data/household_power_consumption.txt")
UCI_HCP$Date <- dmy(UCI_HCP$Date)

# setting general parameters

par(mfrow = c(2, 2))
Sys.setlocale("LC_TIME","en_US")

# Build graph 1-----------------------------------------------------------------

# subset
Plot2 <- UCI_HCP %>% 
            filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
            select(Date, Time, Global_active_power) %>%
            group_by(Date)

# Paste Days & time
Plot2$period <- paste(Plot2$Date, Plot2$Time, sep = " ")

# Set variable to correct class
Plot2$Global_active_power <- as.numeric(Plot2$Global_active_power)
Plot2$period <- ymd_hms(Plot2$period)

# Generate graph
plot(Plot2$period, 
     Plot2$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power")
       

# Build graph 2 ----------------------------------------------------------------

# subset
Plot5 <- UCI_HCP %>% 
            filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
            select(Date, Time, Voltage) %>%
            group_by(Date)

# Paste Days & time
Plot5$period <- paste(Plot5$Date, Plot5$Time, sep = " ")

# Set variable to correct class
Plot5$Voltage <- as.numeric(Plot5$Voltage)
Plot5$period <- ymd_hms(Plot5$period)

# Generate graph
plot(Plot5$period, 
     Plot5$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Build graph 3 ----------------------------------------------------------------

# subset
Plot3 <- UCI_HCP %>% 
            filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
            select(Date, Time, Sub_metering_1:Sub_metering_3) %>%
            group_by(Date)

# Clean Raw dataset
#remove(UCI_HCP)

# Paste Days & time
Plot3$period <- paste(Plot3$Date, Plot3$Time, sep = " ")
Plot3$period <- ymd_hms(Plot3$period)

# Set variable to correct class /!\ NOT WORKING
Plot3$Sub_metering_1 <- as.numeric(Plot3$Sub_metering_1)
Plot3$Sub_metering_2 <- as.numeric(Plot3$Sub_metering_2)
Plot3$Sub_metering_3 <- as.numeric(Plot3$Sub_metering_3)

# Generate graph
plot(Plot3$period, 
     Plot3$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
lines(Plot3$period, 
      Plot3$Sub_metering_2,
      col = "red")
lines(Plot3$period, 
      Plot3$Sub_metering_3,
      col = "blue")
legend("topright", 
       pch = "_", 
       col = c("black","red" , "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Build graph 4-----------------------------------------------------------------

# subset
Plot6 <- UCI_HCP %>% 
            filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
            select(Date, Time, Global_reactive_power) %>%
            group_by(Date)

# Paste Days & time
Plot6$period <- paste(Plot6$Date, Plot6$Time, sep = " ")

# Set variable to correct class
Plot6$Global_reactive_power <- as.numeric(Plot6$Global_reactive_power)
Plot6$period <- ymd_hms(Plot6$period)

# Generate graph
plot(Plot6$period, 
     Plot6$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

## -----------------------------------------------------------------------------

# Export Histogram to output folder
dev.copy(png, 
         file = "./output/Plot4.png")
dev.off()

# get back to local TZ
Sys.setlocale("LC_TIME","fr_FR.UTF-8")

# get back to 1x1 grid for plts
par(mfrow = c(1, 1))

# Clean environment
rm(list=ls())
