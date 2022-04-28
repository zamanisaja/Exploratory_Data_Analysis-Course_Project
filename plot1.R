# 1st assignment from: Instructions.md#Assignment
# 1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.

if (!"NEI" %in% ls()) {
    source("readData.R")
}

pm <- NEI %>%
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions))

# saveing plot into an image file
png("plot1.png")
plot(
    x = as.numeric(levels(pm$year)[pm$year]),
    y = pm$TotalEmissions,
    pch = 16, col = "black", cex = 2,
    xlab = "Year", ylab = "Total Emissions",
    main = "Total Emissions from PM2.5",
)

dev.off()