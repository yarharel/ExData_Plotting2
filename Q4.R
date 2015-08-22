## NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
SCC_Comb<- SCC %>% filter(SCC.Level.One %in% c('External Combustion Boilers',
                                       'Internal Combustion Engines',
                                       'Stationary Source Fuel Combustion')) %>%
           select(SCC)
CombYearData<-subset(NEI,SCC %in% SCC_Comb$SCC,select=c(year,Emissions))  %>%
  group_by(year) %>% 
  select(year,Emissions) %>% 
  summarise(Emissions=sum(Emissions))
png("plot4.png")
plot(CombYearData$year,CombYearData$Emissions,type="b",xlab = "Year"
     ,ylab="Total Emissions",xaxt="n",xlim=c(1999,2008)
     ,main="Combustion-Related Yearly Emissions")
ticks<-c(1998:2008)
axis(side = 1,at=ticks,labels=ticks)
dev.off()