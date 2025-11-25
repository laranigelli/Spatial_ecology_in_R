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
