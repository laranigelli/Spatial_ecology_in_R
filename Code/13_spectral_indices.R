# This script helps calculating spectral indices 

library(terra)
library(inageRy)
library(viridis)

#List files 
im.list()

m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")

#image composed by 3 layers. 
#layer 1 = NIR
#layer 2 = RED
#layer 3 = GREEN
im.plotRGB(m1992, r=1,g=2,b=3)
# everything that reflects NIR becomes red
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m1992, r=2, g=3, b=1)
# everything that reflects NIR becomes blue 
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006,r=1,g=2,b=3)
im.plotRGB(m2006,r=3,g=2,b=1)

#how much the biomass changed in time
#spectral indices to help us make calculation on the state of vegetation
#dvi
# reflectance with a range 0-100
# that vegetation has the following behavior in NIR and red 
#NIR: vegetation reflects a lot. 90
#red: absorbs wavelenght so small reflectance. 10
# difference between the two bands NIR-red= DVI -> 90-10=80 in case of health vegetation
# in case of stressed vegetation
# NIR: decreases. 60
# red: not absorbing so much, part of it is reflected. 20
# DVI = 60-20=40

# Calculating DVI 
# layer 1= NIR, layer 2= red, layer 3= green
dvi1992=m1992[[1]]-m1992[[2]]
dvi2006=m2006[[1]]-m2006[[2]]

par(mfrow=c(1,2))
plot(dvi1992)
plot(dvi2006)

par(mfrow=c(1,2))
plot(dvi1992, col=inferno(100))
plot(dvi2006, col=inferno(100))

# to standardize data NIR-RED/NIR+RED. despite the range of data, the range will be always from -1 +1
ndvi1992<-im.ndvi(m1992,1,2)
ndvi2006<-im.ndvi(m2006,1,2)
plot(ndvi1992, col=inferno(100))
plot(ndvi2006, col=inferno(100))

# range of ndvi
# 0-100
# ndvi= (nir-red)/(nir+red)=(100-0)/(100+0)=1 when nir is max
# ndvi=(0-100)/(0+100)=-1 when red is max
# ndvi will always range from -1 to +1. 

# 0-100
# dvi= (nir-red)=(100-0)=100 
# dvi=(0-100)= -100
