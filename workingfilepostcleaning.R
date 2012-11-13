jan<-read.csv("ensemble1_jan.csv")
last20<-read.csv("ensemble1_last20.csv")
monthly<-read.csv("monthlyglobaldev.csv")
library(ggplot2)
library(lubridate)
library(RColorBrewer)
library(maps)

jan2012<-subset(jan,realyear==2012)
sep2012<-subset(last20,((realyear==2012)&(month==9)))

worldmap<-map_data("world")
p<-ggplot()
p <- p + geom_polygon( data=worldmap, aes(x=long, y=lat, group = group),colour="black", fill="white" )+ theme(aspect.ratio=1/2)
p<-p+geom_tile(data=jan2012, aes(x=long,y=lat,fill=value,alpha=.25))+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")
p

q<-ggplot()
q <- q + geom_polygon( data=worldmap, aes(x=long, y=lat, group = group),colour="black", fill="white" )+ theme(aspect.ratio=1/2)
q<-q+geom_tile(data=sep2012, aes(x=long,y=lat,fill=value, alpha=.25))+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")
q

recent<-subset(monthly, fixedtime>1990)
qplot(fixedtime,anomaly,data=recent,color=anomaly) + geom_smooth()