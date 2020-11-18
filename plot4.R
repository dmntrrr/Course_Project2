library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

sources <- grep("Coal", levels(SCC$EI.Sector), value = TRUE)
dataSCC <- SCC %>% select(SCC, EI.Sector) %>% filter(EI.Sector == sources)

DATA <- merge(NEI, dataSCC, by.x = "SCC", by.y = "SCC")
DATA <- DATA %>% group_by(year) %>% summarise(total = sum(Emissions))

png("plot4.png")
ggplot(DATA, aes(year, total)) + geom_line() + theme_bw() +
    ylab("Total emissions (in tons)") + 
    ggtitle("Total emissions from coal combustion-related sources in 1999-2008")
dev.off()