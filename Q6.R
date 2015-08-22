## NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
SCC_Comb<- SCC %>% filter(SCC.Level.One =='Internal Combustion Engines')  %>% 
  select(SCC)
CombYearData<-subset(NEI,SCC %in% SCC_Comb$SCC,select=c(year,fips,Emissions))  %>%
  filter(fips %in% c("24510","06037")) %>%
  group_by(year,fips) %>% 
  select(year,fips,Emissions) %>% 
  summarise(Emissions=sum(Emissions))
CombYearData$fips<-factor(CombYearData$fips,labels=c("Los Angeles","Baltimore"))
png("plot6.png",width=640)
g<-ggplot(CombYearData, aes(year, Emissions)) 
g    +	
  geom_point() +
  ##facet_grid(. ~ fips) +
  facet_wrap( ~ fips, scales = "free") +
  xlim(1999,2008) +
  geom_smooth(method = "lm",se=FALSE) +
  ggtitle("LA,Baltimore Yearly Emissions") +
  theme(plot.title = element_text(vjust=2))
dev.off()