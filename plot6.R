library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sources <- grep("Vehicles", levels(SCC$EI.Sector), value = TRUE)
dataSCC <- SCC %>% select(SCC, EI.Sector) %>% filter(EI.Sector == sources)

DATA <- merge(NEI, dataSCC, by.x = "SCC", by.y = "SCC")
DATA <- DATA %>% filter(fips == "24510" | fips == "06037") %>%
                 group_by(year, fips) %>% summarise(total = sum(Emissions))
DATA <- transform(DATA, fips = factor(fips, levels = c("06037", "24510"), 
                                      labels = c("LA", "Baltimore")))

png("plot6.png")
ggplot(DATA, aes(year, total)) + geom_line() + theme_bw() + facet_wrap(. ~ fips) +
    ylab("Total emissions (in tons)") + 
    ggtitle("Total emissions from vehicle sources in Baltimore and LA in 1999-2008")
dev.off()