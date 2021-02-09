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

# Prepare dataset
UCI_HCP <- read.csv2("./data/household_power_consumption.txt")
UCI_HCP$Date <- dmy(UCI_HCP$Date)

Plot1 <- UCI_HCP %>% 
            filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
            select(Date, Global_active_power)
# Clean Raw dataset
remove(UCI_HCP)

# Set variable to correct class
Plot1$Global_active_power <- as.numeric(Plot1$Global_active_power)

# Generate histogram
hist(Plot1$Global_active_power, 
     freq = TRUE, 
     breaks = 24,
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")            

# Export Histogram to output folder
dev.copy(png, 
         file = "./output/Plot1.png")
dev.off()

# Clean environment
rm(list=ls())
