# this code is rekated to multivariate analysis of RS dara

library(imageRy)
library(terra)
library(ggplot2)
library(patchwork)
library(viridis)

sent<-im.import("sentinel.png")
p1<-im.ggplot(sent[[1]])
p2<-im.ggplot(sent[[2]])
p3<-im.ggplot(sent[[3]])

p1+p2+p3

names(sent)<-c("b01_nir","b02_red","b03_green")
pairs(sent)

sentpc<-im.pca(sent)

pcsd3<-focal(sentpc[[1]],w=3,fun="sd")

sd3<-focal(sent[[1]],w=3,fun="sd")
p1<-im.ggplot(sd3)
p2<-im.ggplot(pcsd3)

p1+p2


