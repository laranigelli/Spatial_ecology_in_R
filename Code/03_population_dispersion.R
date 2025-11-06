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
# absences are not as certain as presences, species may be absent or it was there but we did not see it so we don't know if it is a real absence or the problem is related to the operator (pseudo absences).
# inside rana there is a table with occurrences, we can select only those related to 1

# dividing presences from absences by doing a subset. == means the SQL, we are selectig the points where occurrence =1. the subset is done by []

pres <- rana[rana$Occurrence==1]
plot(pres)

# select all absences 
abs <- rana[rana$Occurrence==0]
# or ! means is not
abs <- rana[rana$Occurrence!=1]

plot(abs)

# plot the presences with a color together with absences with another color. if i use plot i overlap the previous plot with the next one, i use points

plot(pres, col="#EE6A50")

points(abs, col="#556B2F")

# do the same in a multiframe with the two sets, pres on top of absences. 
par(mfrow=c(2,1))
plot(pres, col="#EE6A50")
plot(abs, col="#556B2F")

# ancillary data : data connected to the life of the organisms like elevation

# Covariates
elev <- system.file("external/elevation.asc", package="sdm")

# rast because it is a rasted file
elevmap <- rast(elev)

plot(elevmap)

# Exercise: change the colors of the elevation map by the colorRampPalette function
cl <- colorRampPalette(c("green","hotpink","mediumpurple"))(100)
plot(elevmap, col=cl)

# plot presences on top of the map 
points(pres)
# presences where there are low elevations because rana is related to not so high elevations. 

# plot points of one of the other variables
# Exercise: import temperature and plot presences vs temperature. temperature.asc (it is an extention which means ascii). external is the folder where there are all the packages. 
temp <- system.file("external/temperature.asc", package="sdm")
tempmap <- rast(temp)
plot(tempmap)
cl <- colorRampPalette(c("green","hotpink","mediumpurple"))(100)
plot(tempmap, col=cl)
points(pres)

# package to change colorRampPalette -> viridis [https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html], also good for daltonic people 
install.packages("viridis")
library(viridis)

plot(tempmap, col=mako(100))

# exercise: plot elevation and temperature with presences one beside the other 
par(mfrow=c(1,2))
plot(elevmap, col=cl)
points(pres)
plot(tempmap, col=mako(100))
points(pres)

# input precipitation data 
precipitation.asc
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)
plot(precmap)
points(pres)

#vegetation 
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege)
plot(vegemap)
points(pres) 

# if we have a certain taxon somewhere, we will have high amount of another organisms, related to predators models.

# plot rasted data togheter 
# exercise: plot all the ancillary variable in a multiframe
par(mfrow=c(2,2))
plot(elevmap)
plot(tempmap)
plot(vegemap)
plot(precmap)

# we can create an array of maps creating a stack. every single map represent elements of an array so concatenate them to create a stack. this requires terra package
anci <- c(elevmap, tempmap, precmap, vegemap)
plot(anci, col=magma(100))
