library(tidyverse)

if (!file.exists("data")) {
    dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(dataurl, destfile = "data.zip")
    unzip("data.zip", exdir="data")
    file.remove("data.zip")
}

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

df <- NEI %>%
    group_by(year, type) %>%
    summarise(TotalEmissions = sum(Emissions))


g <- ggplot(data = df)

g +
    geom_line(aes(x = year, y = TotalEmissions, color = type, group = type)) +
    geom_point(aes(x = year, y = TotalEmissions, color = type))
