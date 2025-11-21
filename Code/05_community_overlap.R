# Code to estimate the temporal overlap between species
# how much time animals are spending togheter? 
# the package is overlap that estimates the amount of overlapping for animal activity
install.packages("overlap") # this package uses kernel density
# the tool calculates time
library(overlap)
data(kerinci)
head(kerinci)
# radiance is the view of time instead as linearly as a circular variable 
circtime<-kerinci$Time*2*pi
circtime
kerinci$circtime<-kerinci$Time*2*pi
head(kerinci) # to have circtime (in radiants) in the head of the table

#to select data related to tiger 
tiger<-kerinci[kerinci$Sps=="tiger",] #, is used to close the selection

#density plot measures the frequency of when we saw the tiger and it will make a continous function that interpolated the picks of the histogramme
densityPlot(tiger$circtime)

tigertime <- tiger$circtime
densityPlot(tigertime)

# erxercise: repeat the graph for the macaque [SQL]
macaque<-kerinci[kerinci$Sps=="macaque",] 
macaque
densityPlot(macaque$circtime)
macaquetime<- macaque$circtime
densityPlot(macaquetime)

# build the list of all the species
# with the function unique i can select unique data from the dataset
species_list<-unique(kerinci$Sps)

# then i can prepare the multiframe to do the loop: for every single species in the list, do the same function declared by me so use {}
par(mfrow = c(3, 3))  # Example: 3 rows and 3 columns (adjust as needed)

# Loop through each species and create density plots
for (species in species_list) {
  # Subset data for the current species
  species_data <- kerinci[kerinci$Sps == species, ]
  
  # Create a density plot for the 'circ' variable of the current species
  plot(density(species_data$circtime), 
       main = paste("Density Plot of Circumference for", species), 
       xlab = "Circumference")
}

# overlap plot considers two different times in 2 datasets and compare them
overlapPlot(tigertime, macaquetime)
