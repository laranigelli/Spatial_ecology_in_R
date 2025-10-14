# code related for population in ecology 
# install the package 
install.packages("spatstat")

# function to use the package already installed 
library(spatstat)

# inside the package there are some data 
bei 
plot(bei)

#points may represent distribution of individuals of a population
plot(bei, pch=2)

# all colors in r are described here[https://r-charts.com/colors/]
plot(bei, pch=2, col="aquamarine")

plot(bei, pch=2, cex= .5)

#for the same area we can have additional points 
bei.extra 
plot(bei.extra)

#how to plot only one variable 
plot(bei.extra$elev)

#another manner explicing only the variable i am interested in. double [] because i have 2 dimensions, for raster dataset  
plot(bei.extra[[1]])
plot(bei.extra[[2]])

#assign el to bei.extra[[1]]
el <- bei.extra[[1]]
plot(el)

#to produce the density map 

#passing from points which are vectors of points to map (raster)
beidense <- density(bei)
plot(beidense)

plot(el)
#the higher the elevtion, the lower the density 

plot(beidense)
points(bei, cex=.5)

# plotting together the density map and the elevation

# el object that was the elevation in bei extra dataset. it needs to be linked with bei extra. one object is beidense and the other is el. how to plot the beidense beside el?
# r has a function called par, a parameter related to plots to create a multiframe (mf) meaning that we put inside the same graph several plots) 
# in this case in one single row and 2 colums 

par(mfrow=c(1,2))
plot(beidense)
plot(el)

# plot beidense on top on el map

par(mfrow=c(2,1))
plot(beidense)
plot(el)

# dev.off function: close a plotting device. 
dev.off()

# how to change colors
# colorRampPalette: extend a color palette to a color ramp. it indicates the type of colors we are using. 
# we can concatenate the elements with c

cl <- colorRampPalette(c("green","red","blue")) # never use rainbow color palette for colorblind people that can't distinguish red from green. 
plot(beidense,col=cl)

cl <- colorRampPalette(c("green","red","blue"))(100)
plot(beidense,col=cl)

# change colors 

cl2 <- colorRampPalette(c("honeydew3","hotpink3","indianred"))
plot(beidense, col=cl2)

# plot the beidense with 2 different color ramps, one on top of the other. 

par(mfrow=c(2,1))
cl <- colorRampPalette(c("green","red","blue"))
plot(beidense,col=cl)
cl2 <- colorRampPalette(c("honeydew3","hotpink3","indianred"))
plot(beidense, col=cl2)
