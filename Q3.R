## NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
library(grid)
BaltimoreTypeYearData<-NEI %>%
  filter(fips == "24510") %>%
  group_by(year,type) %>% 
  select(year,type,Emissions) %>% 
  summarise(Emissions=sum(Emissions))
BaltimoreTypeYearData$type<-factor(BaltimoreTypeYearData$type)
png("plot3.png",width = 640,height = 480)
g<-ggplot(BaltimoreTypeYearData, aes(year, Emissions))
g    +	
  geom_point() +
  facet_grid(. ~ type) +
  geom_smooth(method = "lm",se=FALSE) +
  ggtitle("Baltimore Yearly Emissions by Type") +
  theme(plot.title = element_text(vjust=2))
       
dev.off()