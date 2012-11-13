
temp <- read.csv("anomalies.csv",header=T)
temp$row <- 1:nrow(temp)
temp <- subset(temp,row %% 37 != 0)
temp$row <- 1:nrow(temp)
temp$yloc <- temp$row %% 36
temp$yloc[temp$yloc == 0] <- 36

#time is time in months since Jan 1850
#month in month # of year
#year is number of years ince 1850
temp$time <- ((temp$row - 1) %/% 36) + 1
temp$month <- (temp$time %% 12)
temp$month[temp$month == 0] <- 12
temp$year <- ((temp$time - 1) %/% 12) + 1
names(temp) <- c(1:72,"row","yloc","time","month","year")

library(reshape2)

temp.melt <- melt(temp, id.vars=c("time","month","year","yloc"),id.values=1:72)
names(temp.melt)[5] <- "xloc"
temp.melt$value[temp.melt$value==-99.99] <- NA
View(temp.melt)
