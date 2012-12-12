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
annual$realyear<-(annual$year+1849)

jan$long<-(180-jan$xloc*5)
jan$lat<-(90-jan$yloc*5)
last20$long<-(180-last20$xloc*5)
last20$lat<-(90-last20$yloc*5)
annual$long<-(180-annual$xloc*5)
annual$lat<-(90-annual$yloc*5)

ensemble1$long<-(ensemble1$xloc*5)
ensemble1$lat<-(90-ensemble1$yloc*5)

write.csv(ensemble1,"ensemble1.csv")

jan2012<-subset(jan,realyear==2012)
sep2012<-subset(last20,((realyear==2012)&(month==9)))
summary(sep2012)
summary(jan2012)
write.csv(jan,"ensemble1_jan.csv")
write.csv(last20,"ensemble1_last20.csv")
write.csv(monthly,"monthlyglobaldev.csv")
write.csv(annual,"annualensemble1.csv")
library(maps)
qplot(long,lat,data=jan2012,fill=value, geom="tile",xlim=c(-180,180),ylim=c(-90,90))+ theme(aspect.ratio=1/2)+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")
# adding +scale_fill_brewer(palette="Spectral")    should change the palette, but it borks
#i think we need to use ggplot instead of qplot to get the map to work right

jan2012$lat<-jan2012$lat+2.5 #fiddling with these to get them to show up right
sep2012$lat<-sep2012$lat+2.5
jan2012$long<-jan2012$long+2.5
sep2012$long<-sep2012$long+2.5
worldmap<-map_data("world")
p<-ggplot()
p <- p + geom_polygon( data=worldmap, aes(x=long, y=lat, group = group),colour="black", fill="white" )+ theme(aspect.ratio=1/2)
p<-p+geom_tile(data=jan2012, aes(x=long,y=lat,fill=value,alpha=.25))+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")
p

q<-ggplot()
q <- q + geom_polygon( data=worldmap, aes(x=long, y=lat, group = group),colour="black", fill="white" )+ theme(aspect.ratio=1/2)
q<-q+geom_tile(data=sep2012, aes(x=long,y=lat,fill=value, alpha=.25))+  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0,space = "rgb", na.value = "grey50",guide = "colourbar")
q


%did this much later
ensemble1$fixedyear<- ensemble1$year +1849
ensemble1$fixedtime<-paste(ensemble1$month,ensemble1$fixedyear,sep="/1/")
ensemble1<-subset(ensemble1, select= -X.1)
head(ensemble1)
write.csv(ensemble1,"ensemble1.csv")


onlyfornow<-read.csv("ensemble1.csv")
onlyfornow$realyear<-onlyfornow$year+1849
onlyfornow$fixedyear<-onlyfornow$realyear
onlyfornow<-subset(onlyfornow,select= -c(X.1,X))
write.csv(onlyfornow,"ensemble1.csv")
storycounty<-subset(onlyfornow,lat==40 & long==-95 & realyear>1865)
write.csv(storycounty,"storycounty.csv")
augsburg<-subset(onlyfornow,lat==50 & long==10)
write.csv(augsburg,"augsburg.csv")
antarctica<-subset(onlyfornow,lat==-75 & long==15 & realyear>1960)
write.csv(antarctica,"antarctica.csv")

