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



# Set temporary TZ to en_US

Sys.setlocale("LC_TIME","en_US")

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
legend("topright", pch = "_", col = c("black","red" , "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Export Histogram to output folder
dev.copy(png, 
         file = "./output/Plot3.png")
dev.off()

# get back to local TZ
Sys.setlocale("LC_TIME","fr_FR.UTF-8")

# Clean environment
rm(list=ls())