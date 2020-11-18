library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- NEI %>% filter(fips =="24510") %>% group_by(year) %>% 
                summarise(total = sum(Emissions))

png("plot2.png")
with(data, plot(total ~ year, 
                type = "l", 
                main = "Total emissions during 1999-2008 in Baltimore City",
                ylab = "Total emissions (in tons)",
                ylim = c(min(total)-min(total)/2, max(total)+min(total)/2)))
dev.off()