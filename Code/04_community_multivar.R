# code for perfoming multivariate analysis with community abundance matrices
install.packages("vegan")
library(vegan)

# inside this package there is dune data, representing the dune system
data(dune)

# if we have a hufe dataset, we can use the head function that shows the first six rows. 
head(dune)

# decorana function is one of many multivariate analysis. 
multivar <- decorana(dune)
multivar 
# we have the lenght of the axes that represents in terms of abundances the final lenght of each axis. once dealing with PCA, the lenght of PC1 is higher than the lenght of PC2. 
# total lenght and so the percentage is given by the sum of the lenghts
dcal1 <- 3.7004 # a mathematical funcion i can also use = 
dcal2 = 3.1166
dcal3 = 1.30055
dcal4 = 1.47888 # we expect that the lenght diminushes 
total = dcal1+dcal2+dcal3+dcal4
# or
total <- sum(c(dcal1, dcal2, dcal3, dcal4)) # concatenated because they are elements of the same array

percdcal1 = dcal1 * 100 / total
percdcal2 = dcal2 * 100 / total
percdcal1+percdcal2 

plot(multivar)

#with dca we underestimate, this does not happen with pca. every pca is higher than the other, it is a correted value. the plot with multi pca is more compact in the center with spreads every where, the plot for multivar is diffierent with species better represented
multipca -> pca (dune)
# non-linear dimensional scale is similar to decorana correspondence analysis
# with multivariate analysis we compact the plots and see them in a multivariate space.
