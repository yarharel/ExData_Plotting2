## NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
BaltimoreYearData<-NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>% 
  select(year,Emissions) %>% 
  summarise(Emissions=sum(Emissions))
png("plot2.png")
with(BaltimoreYearData,
plot(year,Emissions,type="b",xlab = "Year"
     ,ylab="Total Emissions",xaxt="n",xlim=c(1999,2008)
     ,main="Baltimore Yearly Emissions"))
ticks<-c(1998:2008)
axis(side = 1,at=ticks,labels=ticks)
model<-lm( Emissions~year,BaltimoreYearData)
abline(model,lwd=2,col="blue")
dev.off()