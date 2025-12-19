# code to resolve colorblindness problems 
library(terra)
setwd("C:/Users/A315-59-530X/Desktop/uni/GCE/secondo anno/SPATIAL ECOLOGY IN R")
vini<-rast("vinicunca.jpg")
vini<-flip(vini)
plot(vini)

#copy paste the function cblind.plot from https://github.com/ducciorocchini/cblindplot/blob/main/R/cblind.plot.R
# cvd= color vision deficiency
cblind.plot(vini, cvd="protanopia")

rb<-rast("rainbow.jpg")
rb<-flip(rb)
plot(rb)
cblind.plot(rb, cvd="protanopia")
cblind.plot(rb, cvd="deuteranopia")
cblind.plot(rb, cvd="tritanopia")
