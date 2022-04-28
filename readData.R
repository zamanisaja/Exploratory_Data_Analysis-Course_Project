library(tidyverse)

if (!file.exists("data")) {
    dataurl <- "https://d396qusza40orc.cloudfrontnet/exdata%2Fdata%2FNEI_data.zip"
    download.file(dataurl, destfile = "data.zip")
    unzip("data.zip", exdir = "data")
    kfile.remove("data.zip")
}

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)