# code for performing time series analysis on satellite data
library(terra)
library(imageRy)
# install.packages("ggridges")
library(ggridges) #takes the frequency of data in a smooth function
library(ggplot2)
library(viridis)
library(patchwork)

#listing files 
im.list()
# EN: nitrogen dispersal in europe in several periods. lower the amount od human displacements, lower should be the amount of no2. 

# importing data 
EN01<-im.import("EN_01.png")
plot(EN01)
EN01<-flip(EN01)
plot(EN01)

# most data are extended from 0 to 255. 8 bit images. intergel values. most of the images are in 8 bit so the final layer will be from 0 to 255 (2^8=256, we need to consider also the 0)
# the radiometric resolution of EN01 is 8 bit. 

EN13<-im.import("EN_13.png")
EN13<-flip(EN13)
plot(EN13)

# what are the parts of the images where there is higher difference? the difference between january values of the first layer and the first layer of march
diffEN=EN01[[1]]-EN13[[1]]
# it ranges from -255 and 255

# ridgeline plots
# we can import all data in a stack by using the common name they share 
ndvi<-im.import("NDVI_2020")
im.ridgeline(ndvi, scale=1) #they have the same names, they overwrite each other. we can change the names of dataset 
names(ndvi)=c("02_feb","05_may","08_aug","11_nov")
im.ridgeline(ndvi, scale=1) # now it works
im.ridgeline(ndvi, scale=2) # scale = is a parameter to enhance differences. 2 is the best option
im.ridgeline(ndvi, scale=3)
im.ridgeline(ndvi, scale=4)
im.ridgeline(ndvi, scale=10) #quite ugly now

# example: ice melt in Greenland 
gr<-im.import("greenland")
plot(gr) #only 3 shows out of 4
names(gr)=c("y2000","y2005","y2010")
diffgr=gr[[1]]-gr[[3]]
plot(diffgr)
plot(diffgr, col=magma(100))

im.ridgeline(gr, scale=2) 
#ridgline plotting with external images 
setwd("C:/Users/A315-59-530X/Desktop/uni/GCE/secondo anno/SPATIAL ECOLOGY IN R")
p2<-rast("p2.png")
p2<-c(p2$p2_1,p2$p2_2,p2$p2_3) #to take the first 3 layers
plot(p2)
im.plotRGB(p2,1,2,3)
im.ridgeline(p2, scale=2)

p1<-rast("p1.png")
p1<-c(p1$p1_1,p1$p1_2,p1$p1_3)
plot(p1)
im.plotRGB(p1,1,2,3)
im.ridgeline(p1, scale=2)

#tidyverse to put everything together 
plot1<-im.ggplot(p1[[1]])
plot2<-im.ggplot(p2[[1]])
plot3<-im.ridgeline(p1, scale=2)
plot4<-im.ridgeline(p2, scale=2)

plot1+plot2+plot3+plot4 
