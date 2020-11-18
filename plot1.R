library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- NEI %>% group_by(year) %>% summarise(total = sum(Emissions))

png("plot1.png")
with(data, plot(total ~ year, 
                type = "l", 
                main = "Total emissions in USA during 1999-2008",
                ylab = "Total emissions (in tons)",
                ylim = c(min(total)-min(total)/2, max(total)+min(total)/2)))
dev.off()