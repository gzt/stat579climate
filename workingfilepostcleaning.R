jan<-read.csv("ensemble1_jan.csv")
last20<-read.csv("ensemble1_last20.csv")
monthly<-read.csv("monthlyglobaldev.csv")
library(ggplot2)
library(lubridate)
library(RColorBrewer)
library(maps)
library(scale)


jan2012<-subset(jan,realyear==2012)
sep2012<-subset(last20,((realyear==2012)&(month==9)))

worldmap<-map_data("world")
p<-ggplot()
p <- p + geom_polygon( data=worldmap, aes(x=long, y=lat, group = group),colour="black", fill="white" )+ theme(aspect.ratio=1/2)+coord_cartesian(ylim=c(-90,90), xlim=c(-180,180))+scale_y_continuous(breaks=seq(-90, 90, 15))+scale_x_continuous(breaks=seq(-180, 180, 15))
p<-p+geom_tile(data=jan2012, aes(x=(long+2.5),y=lat,fill=value,alpha=.25))+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")+theme_bw()
p

q<-ggplot()
q <- q + geom_polygon( data=worldmap, aes(x=long, y=lat, group = group),colour="black", fill="white" )+ theme(aspect.ratio=1/2)+coord_cartesian(ylim=c(-90,90), xlim=c(-180,180))+scale_y_continuous(breaks=seq(-90, 90, 15))+scale_x_continuous(breaks=seq(-180, 180, 15))
q<-q+geom_tile(data=sep2012, aes(x=-(long+2.5),y=lat,fill=value, alpha=.25))+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")+theme_bw()
q
monthly$fixedtime<-ymd(monthly$fixedtime)
recent<-subset(monthly, fixedtime>1990)
qplot(fixedtime,anomaly,data=monthly,geom="line",color=anomaly) + geom_smooth(se=FALSE,color="red")
recent<-subset(monthly, year(fixedtime)>1975)
qplot(fixedtime,anomaly,data=recent) + geom_smooth(method="lm", se=FALSE)
annual<-read.csv("annualensemble1.csv")


y2k<-subset(annual, realyear==2011)
year2000<-ggplot()
year2000 <- year2000 + geom_polygon( data=worldmap, aes(x=long, y=lat, group = group),colour="black", fill="white" )+ theme(aspect.ratio=1/2)+coord_cartesian(ylim=c(-90,90), xlim=c(-180,180))+scale_y_continuous(breaks=seq(-90, 90, 15))+scale_x_continuous(breaks=seq(-180, 180, 15))
year2000<-year2000+geom_tile(data=y2k, aes(x=(long+2.5),y=(lat+2.5),fill=newvalue, alpha=.25))+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")+theme_bw()
year2000

summary(subset(annual, realyear==2000))