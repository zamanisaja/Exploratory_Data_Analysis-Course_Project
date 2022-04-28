# 6th assignment from: Instructions.md#Assignment
# Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County,
# California fips == "06037".
# Which city has seen greater changes over time in motor vehicle emissions?
if (!"NEI" %in% ls()) {
    source("readData.R")
}

motorVehicle <- dplyr::filter(SCC, grepl("Vehicle", Short.Name))

pmLA <- NEI %>%
    filter(SCC %in% motorVehicle$SCC) %>%
    subset(fips == "06037") %>%
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions))

pmBA <- NEI %>%
    filter(SCC %in% motorVehicle$SCC) %>%
    subset(fips == "24510") %>%
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions))

pmBA$city <- rep("Baltimore", 4)
pmLA$city <- rep("Los Angeles", 4)
pm <- rbind(pmBA, pmLA)
pm$city <- as.factor(pm$city)

ggplot(data = pm) +
    geom_point(aes(x = year, y = TotalEmissions, group = city), size = 2.5) +
    geom_line(aes(x = year, y = TotalEmissions, group = city, color = city)) +
    labs(x = "Year", y = "Total Emissions", title = "Baltimore vs. Los Angeles")
ggsave("plot6.png")