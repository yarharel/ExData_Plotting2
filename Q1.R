##Loading files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Grouping data by year using dplyr Package
library(dplyr)
YearData<-NEI %>% 
  group_by(year) %>% 
  select(year,Emissions) %>% 
  summarise(Emissions=sum(Emissions))

##creating the image
png("plot1.png")
plot(YearData$year,YearData$Emissions,type="b",xlab = "Year"
     ,ylab="Total Emissions",xaxt="n",xlim=c(1999,2008)
     ,main="Yearly Emissions")
ticks<-c(1998:2008)
axis(side = 1,at=ticks,labels=ticks)
dev.off()