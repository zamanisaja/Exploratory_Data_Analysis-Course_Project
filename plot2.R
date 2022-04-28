# 2nd assignment from: Instructions.md#Assignment
# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

if (!"NEI" %in% ls()) {
    source("readData.R")
}

pm <- NEI %>%
    subset(fips == "24510") %>% # fips=24510 for Baltimore City
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions))

png("plot2.png")
plot(
    x = as.numeric(levels(pm$year)[pm$year]),
    y = pm$TotalEmissions,
    pch = 16, col = "black", cex = 2,
    xlab = "Year", ylab = "Total Emissions",
    main = "Total Emissions from PM2.5 in Baltimore City, Maryland",
)
dev.off()