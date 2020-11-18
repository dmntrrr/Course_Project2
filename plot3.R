library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- NEI %>% select(-(SCC:Pollutant)) %>% filter(fips =="24510") %>% 
    group_by(year, type) %>% summarise(total = sum(Emissions))

png("plot3.png")
ggplot(data, aes(year, total)) + geom_line() + facet_wrap(.~ type) + theme_bw() +
                                 ylab("Total emissions (in tons)") + 
                                 ggtitle("Total emissions in Baltimore in 1999-2008")
dev.off()