# sdm: species distribution modelling
# install the package sdm 

install.packages("sdm")
library(sdm)
library(terra)

# in sdm we can search for a file called species.shp (Shape file). system.file find names of r system files 
file <- system.file("external/species.shp",package="sdm")

# we need to convert the file with the vect function that creates a spatvector, a vector of coordinates spread in the space.

rana <- vect(file)
plot(rana)

# data stored for each point
rana$Occurrence
