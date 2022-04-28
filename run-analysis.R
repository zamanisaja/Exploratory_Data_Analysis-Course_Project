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

df1 <- NEI %>%
    group_by(year, type) %>%
    summarise(TotalEmissions = sum(Emissions))

df2 <- NEI %>%
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions))
df2$type <- as.factor(rep("SUM", times = 4))

# require(gridExtra)
# can use gridExtra to plot the data
myplot <- ggplot(data = rbind(df1, df2)) +
    geom_line(aes(x = year, y = TotalEmissions, color = type, group = type)) +
    geom_point(aes(x = year, y = TotalEmissions, color = type))

png("plot1.png")
plot(
    x = as.numeric(levels(df2$year)[df2$year]),
    y = df2$TotalEmissions,
    pch = 16, col = "black", cex = 2,
    xlab = "Year", ylab = "Total Emissions",
)
dev.off()


pmBaltimore <- subset(NEI, fips == 24510)
dfBaltimore <- pmBaltimore %>%
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions))

png("plot2.png")
plot(
    x = as.numeric(levels(dfBaltimore$year)[dfBaltimore$year]),
    y = dfBaltimore$TotalEmissions,
    pch = 16, col = "black", cex = 2,
    xlab = "Year", ylab = "Total Emissions",
)
dev.off()