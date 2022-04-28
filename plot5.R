# 5th assignment from: Instructions.md#Assignment
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

if (!"NEI" %in% ls()) {
    source("readData.R")
}

# I'm assumming all motor vehicle sources have "Motor Vehicle" in their Short.Name
motorVehicle <- dplyr::filter(SCC, grepl("Vehicle", Short.Name))

pm <- NEI %>%
    filter(SCC %in% motorVehicle$SCC) %>%
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions))

ggplot(pm) +
    geom_line(aes(x = year, y = TotalEmissions, group = 1)) +
    geom_point(aes(x = year, y = TotalEmissions), size = 2.5) +
    labs(x = "Year", y = "Total Emissions", title = "Total Emissions from Coal Combustion-Related Sources")
ggsave("plot5.png")