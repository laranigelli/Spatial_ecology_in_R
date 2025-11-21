# Code for graph theory in ecology
# install.packages("igraph")
library(igraph)

# build a network of different organisms
species <- c("Algae","Zooplankton","Small Fish","Large Fish","Bird")

# call a column predator and a column called prey
predator <- c("Zooplankton", "Small Fish","Large Fish", "Bird")
prey <- c("Algae", "Zooplankton", "Small Fish", "Small Fish")

# to build the dataframe
interactions <-data.frame(predator,prey)

# graph from dataframe: creating igraph graphs from data frame
g<-graph_from_data_frame(interactions,vertices=species, directed=TRUE)

# vertices are the different species 
plot(g)
g<-graph_from_data_frame(interactions,vertices=species, directed=F)

#set.seed() function: Seeding Random Variate Generators. i see one of the main potential graph 
set.seed(42)
g<-graph_from_data_frame(interactions,vertices=species, directed=TRUE)
plot(g)
