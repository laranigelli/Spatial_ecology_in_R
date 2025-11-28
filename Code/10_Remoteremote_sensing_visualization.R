# Zenodo set: https://zenodo.org/records/15645465 it is an archive for data. 
# install.packages("imageRy")
library(imageRy)
im.list() #to see data inside the package
library(terra)
library(viridis)
# sentinel is a programe from european space agency
# import data
# https://custom-scripts.sentinel-hub.com/custom-scripts/sentinel-2/bands/
# band 2 is the blue. data will have a range and the reflectance in blue. all of the objects that reflect part of all of the blue band. 
b2 <- im.import("sentinel.dolomites.b2.tif")
plot(b2)
# this image is related to tofane (Italy area), huge mountains in dolomites near bolzano. 
# y is the distance from the equator x is the distance from the central meridian. at central x we have no 0 because it has a false origin of 5 hundred thousand meters
# the palette is chosen as default based on the palettes present in terra (viridis palette). imageRy is based on terra package. 
# yellow represent the maxima, areas where blue is reflecting a lot. dark blue is absorbing the blue wavelenght. 

plot(b2, col=magma(100))
# what was yellow, reflects a lot the blue wavelenght. parts in black absorb the blue wavelenght. everything that has high values (yellow) reflects a lot blue wavelenght.

# a micrometer is divided in 1 thousand pieces, one piece of that is the nanometer
# band 3 represents how much of the central wavelenght is represented. Central Wavelength = 560nm distance between one pick and another
# green band 
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3)
# everything that reflects green is light yellow. everything that absorbs green wavelenght will be dark blue.
# change color ramp palette 
cl<-colorRampPalette(c("black", "grey", "white"))(100)
plot(b3, col=cl)

#multiframe to plot one next to each other
#instead of parmfrow we can use a function in imageRy called im.multiframe that is an equivalent of parmfrow
im.multifrane(1,2)
# not working, we use par
par(mfrow=c(1,2))
plot(b2, col=cl)
plot(b3, col=cl)
# very similar images since the reflectance in this visible part is similar 
# if a function is not working on CRAN, it can be checked in github
im.multiframe <- function(x,y){
  par(mfrow=c(x,y))
  }
# this function from git hub is functioning
im.multiframe(1,2)
plot(b2, col=cl)
plot(b3, col=cl)
# it worked :D
dev.off()
plot(b2,b3)
# they are ultracorrelated with each other. reflectance increases for b2 and b3 
#exercise: import band number 4, corresponding to red wavelenght
b4<-im.import("sentinel.dolomites.b4.tif")
# objects reflecing are represented in yellow, in dark blue those who absorb.
plot(b4)
plot(b4, col=cl)

# infrared is wider than UV
# import band 8 called NIR = near infrared. central wavelenght 842 nm
b8<-im.import("sentinel.dolomites.b8.tif")
plot(b8) 
# we have a huge amount of degradation
im.multiframe(1,2)
plot(b4, col=cl)
plot(b8, col=cl)

# build your own function for plotting. (x,y) is the argument
duccio<-function(x,y){
  par(mfrow=c(x,y))
  }
# exercise: with the function duccio build a multiframe of 2 rows and colums and plot all the imported data
duccio(2,2)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# exercise: create a multiframe with 1 row and 2 columns,plot one against the other 
# b2 and b3
# b2 and b8
duccio(1,2)
plot(b2,b3) # the blue band and the green band. ultracorrelated, they increase and decrease togheter 
plot(b2,b8) # the blue band and the NIR band. not a linear correlation: high reflectance in NIR and low reflectance in blue, it is vegetation since blue is absorbed by vegetation for photosyntesis. NIR adds additional information since it is not directly correlated. 

# creatin colored images.
# function in imageRy package im.plotRGB. we take an image composed by several bands stating what band we want to put on top of each component of RGB scheme.
# first we create the image
# every single band is treated as an element of an array. 
sent <- c(b2,b3,b4,b8)
plot(sent) 
# we create the stack were we have all the bands. 

#layer 1 = original (from sentinel 2) b2 = blue 
#layer 2 = original (from sentinel 2) b3 = green
#layer 3 = original (from sentinel 2) b4 = red 
#layer 4 = original (from sentinel 2) b8 = NIR

# im.plotRGB(x,r,g,b, title="")
# natural color image (how the image is seen from space) 
im.plotRGB(sent, r=3, g=2, b=1, title="natural color")

# false color image 
im.plotRGB(sent, r=4, g=3, b=2, title="false color") # NIR is on top of red component 
im.plotRGB(sent, r=3, g=4, b=2, title="false color") # NIR is on top of green component (credo)
im.plotRGB(sent, r=3, g=2, b=4, title="false color") # NIR of top of blue component 
#duccio(2,2) non funziona with the CRAN version
