# 3rd assignment from: Instructions.md#Assignment
# Of the four types of sources indicated by the type
# (point, nonpoint, onroad, nonroad)variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

if (!"NEI" %in% ls()) {
    source("readData.R")
}

pm <- NEI %>%
    subset(fips == "24510") %>% # fips=24510 for Baltimore City
    group_by(year, type) %>%
    summarise(TotalEmissions = sum(Emissions))

ggplot(pm) +
    geom_line(aes(x = year, y = TotalEmissions, color = type, group = type)) +
    geom_point(aes(x = year, y = TotalEmissions, color = type)) +
    labs(x = "Year", y = "Total Emissions", title = "Baltimore City, Maryland")
ggsave("plot3.png")