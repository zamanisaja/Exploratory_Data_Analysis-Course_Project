# 4th assignment from: Instructions.md#Assignment
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

if (!"NEI" %in% ls()) {
    source("readData.R")
}

# I'm assumming any coal combustion related source has "Coal" in its EI.Sector
coalComb <- dplyr::filter(SCC, grepl("Coal", EI.Sector))

pm <- NEI %>%
    filter(SCC %in% coalComb$SCC) %>%
    group_by(year) %>%
    summarise(TotalEmissions = sum(Emissions))

png("plot4.png")
ggplot(pm) +
    geom_line(aes(x = year, y = TotalEmissions, group = 1)) +
    geom_point(aes(x = year, y = TotalEmissions), size = 2.5) +
    labs(x = "Year", y = "Total Emissions", title = "Total Emissions from Coal Combustion-Related Sources")
dev.off()