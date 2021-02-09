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
Plot2 <- UCI_HCP %>% 
            filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
            select(Date, Time, Global_active_power) %>%
            group_by(Date)

# Clean Raw dataset
remove(UCI_HCP)

# Paste Days & time
Plot2$period <- paste(Plot2$Date, Plot2$Time, sep = " ")

# Set variable to correct class
Plot2$Global_active_power <- as.numeric(Plot2$Global_active_power)
Plot2$period <- ymd_hms(Plot2$period)

# Set temporary TZ to en_US

Sys.setlocale("LC_TIME","en_US")

# Generate graph
plot(Plot2$period, 
     Plot2$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Export Histogram to output folder
dev.copy(png, 
         file = "./output/Plot2.png")
dev.off()

# get back to local TZ
Sys.setlocale("LC_TIME","fr_FR")

# Clean environment
rm(list=ls())