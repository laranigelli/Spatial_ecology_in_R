# sdm: species distribution modelling
# install the package sdm 

install.packages("sdm")
library(sdm)
library(terra)

# in sdm we can search for a file called species.shp (Shape file). system.file find names of r system files 
file <- system.file("external/species.shp",package="sdm")

# we need to convert the file with the vect function that creates a spatvector, a vector of coordinates spread in the space.
# rana has coordinates. WGS is the datum 

rana <- vect(file)
plot(rana)

# data stored for each point
rana$Occurrence

# occurrence is related to the fact that someone went on the field and took data. if the organism was present, the data is =1; if it is not present, the label=0 (this is an absence). 
# the problem is with the absences: the individual may not be there or we did not see it (uncertaintees of pseudo absences). 

# dividing presences from absences by doing a subset. == means the SQL, we are selectig the points where occurrence =1

pres <- rana[rana$Occurrence==1]
plot(pres)

# select all absences 
abs <- rana[rana$Occurrence==0]
#or ! means is not
abs <- rana[rana$Occurrence!=1]

plot(abs)

# plot the presences with a color together with absences with another color. if i use plot i overlap the previous plot with the next one, i use points

plot(pres, col="#EE6A50")

points(abs, col="#556B2F")

# do the same in a multiframe with the two sets, pres on top of absences. 
par(mfrow=c(2,1))
plot(pres, col="#EE6A50")
plot(abs, col="#556B2F")


