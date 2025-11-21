# Introduction to Graph Theory in Ecology

Graph theory provides a powerful set of tools for understanding how organisms interact within ecological systems. In ecological network analysis, species can be represented as **nodes (vertices)**, while their interactions—such as predation—are represented as **edges**. Directed edges allow us to distinguish the flow of energy, matter, or influence (for example, from prey to predator or predator to prey).

In this example, we will use the R package **igraph** to create and visualize a simple ecological food web. This demonstrates how graph theory concepts can be applied to biological systems.

---

## R Code Example

Below is an annotated R script that constructs and visualizes a small ecological network using `igraph`.

```r
# Code for graph theory in ecology
# install.packages("igraph")
library(igraph)

# Build a network of different organisms
species <- c("Algae", "Zooplankton", "Small Fish", "Large Fish", "Bird")

# Define predator-prey relationships\ npredator <- c("Zooplankton", "Small Fish", "Large Fish", "Bird")
prey      <- c("Algae", "Zooplankton", "Small Fish", "Small Fish")

# Create a dataframe of interactions
interactions <- data.frame(predator, prey)

# Create a directed graph from the dataframe
g <- graph_from_data_frame(interactions, vertices = species, directed = TRUE)

# Plot the directed graph
plot(g)

# Create an undirected version of the graph
g <- graph_from_data_frame(interactions, vertices = species, directed = FALSE)

# Use a seed for reproducible layouts
set.seed(42)
g <- graph_from_data_frame(interactions, vertices = species, directed = TRUE)
plot(g)
```

---

## Key Concepts Highlighted

* **Vertices** represent the species in the ecological system.
* **Edges** represent predator–prey interactions.
* **Directed graphs** allow analysis of energy flow.
* **Random seeds** ensure reproducibility of graph layouts.

This simple example can be expanded to explore larger, more complex food webs, analyze connectivity, identify keystone species, and model ecosystem resilience.
