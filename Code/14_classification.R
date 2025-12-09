# this code has been used to classify satellite data
library(terra)
library(imageRy)
library(ggplot2)
# install.packages("patchwork")
library(pachwork)

im.list
m1992 <-im.import("matogrosso_l5_1992219_lrg.jpg")

# from outside the imageRy package: rast() function from terra
# layers: 1= NIR, 2=red; 3=green

plot(m1992) # rgb 123

# exercise import the image from 2006
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")
plot(m2006)

#testing classification

sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
plot(sun) 
# 3 clusters according to energy through im.classify() function
sunc <-im.classify(sun, num_clusters=3) # unsupervised classification
par(mfrow=c(2,1))
plot(sun)
plot(sunc)

# Apply the classification process to the Mato Grosso 

m1992c<-im.classify(m1992, num_clusters=2)
# class 1: rainforest
# class 2: human + water 

#exercise: classify the 2006 image.

m2006c<-im.classify(m2006, num_clusters=2)
# class 1: human + water
# class 2: rainforest

# calculating frequencies 
f1992<-freq(m1992c)

# from frequences i calculate the proportions 
# freq/total number of cells = proportion
tot1992c<-ncell(m1992c)
prop1992=f1992$count / tot1992c

# percentage 
perc1992=prop1992*100
#1992: human= 17%; forest=83%

# you can calculate everything in a single line 
perc1992=freq(m1992c)*100 / ncell(m1992c)

# apply the same reasoning to the image 2006. calculate percentages from image from 2006
perc2006=freq(m2006c)*100 / ncell(m2006c)
# 2006: human=55%; forest= 45%

# let's implement a dataframe with three columns: 
# class
# perc1992
# perc2006

# first build columns 
class<-c("forest","human")
perc1992<-c(83,17)
perc2006<-c(45,55)

# how to do a dataframe 
tabout<-data.frame(class,perc1992,perc2006)
tabout

#ggplot is part of a series of packages that simply graphs in R. 
# final graph. aes= aesthetics, the x, y axes and the colors we want to use. before +, we just have the first part of the graph and nothing happens.
# if i want to make a point graph we put geom_points.
# identity= value per se 
# fill= colors 
p1 <- ggplot(tabout, aes(x=class, y=perc1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))

#ylim function to apply the corrections in the scale, in this case it goes from 0 to 100

# exercise: make the same plot for 2006
p2 <- ggplot(tabout, aes(x=class, y=perc2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))

p1  + p2 # to plot them one next to eachother 
p1 / p2 # to plot them one above the other 
