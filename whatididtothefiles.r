jan<-read.csv("ensemble1_jan.csv")
last20<-read.csv("ensemble1_last20.csv")

summary(last20)

which.max(last20$value)

library(ggplot2)
install.packages("lubridate")
library(lubridate)
install.packages("RColorBrewer")
library(RColorBrewer)
monthly<-read.csv("monthlyglobaldev.csv")
monthly$fixedtime<-ymd(monthly$date)
qplot(fixedtime, anomaly, data=monthly, color=anomaly)
recent<-subset(monthly, fixedtime>1990)
qplot(fixedtime,anomaly,data=recent,color=anomaly) + geom_smooth()
jan$realyear<-(jan$year+1849)
last20$realyear<-(last20$year+1849)

jan$long<-(jan$xloc*5-180)
jan$lat<-(jan$yloc*5-90)
last20$long<-(last20$xloc*5-180)
last20$lat<-(last20$yloc*5-90)

jan2012<-subset(jan,realyear==2012)
summary(jan2012)
write.csv(jan,"ensemble1_jan.csv")
write.csv(last20,"ensemble1_last20.csv")
library(maps)
qplot(long,lat,data=jan2012,fill=value, geom="tile")+ theme(aspect.ratio=1/2)+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")
# adding +scale_fill_brewer(palette="Spectral")    should change the palette, but it borks
#i think we need to use ggplot instead of qplot to get the map to work right