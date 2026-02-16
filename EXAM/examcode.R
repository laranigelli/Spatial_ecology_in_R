# -------------------------------------------------
# Temporal Activity Patterns under Human Disturbance
# Author: Lara Nigelli
# Course: Spatial Ecology in R
# Year: 2026
# -------------------------------------------------

# set your working directory here
# setwd()

# open the packages
library(overlap)
library(lubridate)

# upload and visualize the dataset
mydata <- read.csv("UrbanDataset_Read-Only.csv",sep=";")
head(mydata)

# to convert time in radiants
mydata$circtime <- as.numeric(hms(mydata$Hour)) / 86400 * 2 * pi
# to remove missing time values 
mydata <- mydata[!is.na(mydata$circtime), ]

# To define high and low human presence sites 
human_counts <- table(mydata$Site[mydata$Sps == "Human"])

# To create a list of the "High Sites" by chosing those with more than 25 human observations.
high_human_sites <- names(human_counts[human_counts > 25])

# Impact is the new column added to the dataset to distinguish the low and high impact 
mydata$Impact <- ifelse(mydata$Site %in% high_human_sites, "High", "Low")

# filtering of red fox and roe deer
fox <- mydata[mydata$Sps == "RedFox", ]
roedeer <- mydata[mydata$Sps == "RoeDeer", ]

# division into animals present in high and low sites
fox_high <- fox[fox$Impact == "High", ]
fox_low <- fox[fox$Impact == "Low", ]
roedeer_high <- roedeer[roedeer$Impact == "High", ]
roedeer_low <- roedeer[roedeer$Impact == "Low", ]

# To extract only the time vectors
fox_high_time <- fox_high$circtime
fox_low_time <- fox_low$circtime
roedeer_high_time <- roedeer_high$circtime
roedeer_low_time <- roedeer_low$circtime

# GRAPHS 

# density plot for foxes and roe deers in high impact sites 
densityPlot(fox_high_time, main = "Red Fox activity - High Human Presence")
densityPlot(roedeer_high_time, main = "Roe Deer activity - High Human Presence")

# density plot for foxes and roe deers in low impact sites 
densityPlot(fox_low_time, main = "Red Fox Activity - Low Human Presence")
densityPlot(roedeer_low_time, main = "Roe Deer Activity - Low Human Presence")

# numeric estimate of the overlap
overlap_fox_index <- overlapEst(fox_high_time, fox_low_time, type = "Dhat4")
overlap_fox_index

overlap_roedeer_index <- overlapEst(roedeer_high_time, roedeer_low_time, type = "Dhat4")
overlap_roedeer_index

# to prepare the overlap graphs one next to each other by setting the margins and to create and position one legend for both graphs centered at the bottom
layout(matrix(c(1,2,3,3), nrow = 2, byrow = TRUE), heights = c(4, 0.6))
par(mar = c(4, 4, 3, 1))

# overlap plot to compare high vs. low impact sites for fox 
overlapPlot(fox_high_time, fox_low_time, 
            main = "Comparison Red Fox Activity: High vs Low Human Impact",
            xlab = "Time of the day (Hours)",
            linecol = c("red", "blue"), # red=High, Blue=Low
            olapcol = "lightgrey", # to underline the overlap area
            xscale = 24) # to convert radiants into hours 

# overlap plot to compare high vs. low impact sites for roe deer 
overlapPlot(roedeer_high_time, roedeer_low_time, 
            main = "Comparison Roe Deer Activity: High vs Low Human Impact",
            xlab = "Time of the day (Hours)",
            linecol = c("red", "blue"), # red=High, Blue=Low
            olapcol = "lightgrey", # to underline di overlap area
            xscale = 24)

# we add an external legend 
# to clean the canvas and reset margins to zero before drawing the legend.
par(mar=c(0, 0, 0, 0))
# to create an empty canvas where we can place the legend freely without any axes or data points interfering
plot.new()

legend("center",
       inset = c(0,0),
       legend = c("High Human Presence", "Low Human Presence"), 
       lwd = 2, 
       col=c("red", "blue"), 
       bty = 'n', 
       cex = 1, 
       xpd = TRUE)

dev.off()

# to check for high human disturbance
human_high <- mydata$circtime[mydata$Sps == "Human" & mydata$Impact == "High"]
human_low <- mydata$circtime[mydata$Sps == "Human" & mydata$Impact == "Low"]

densityPlot(human_high, main = "Human Activity: High vs Low Impact Sites", 
            col = "black", lty = 1)
lines(density(human_low, adjust=1.5), col="grey", lty=2)

# prepare data into hours (0-24)
h_high_hours <- human_high * (24 / (2 * pi))
h_low_hours  <- human_low * (24 / (2 * pi))

# create the graph based on High values 
# plot density without x axis (xaxt = "n")
plot(density(h_high_hours, from = 0, to = 24), 
     main = "Human Activity Validation", 
     xlab = "Time of the day", ylab = "Density",
     col = "black", lwd = 2, 
     xlim = c(0, 24), 
     xaxt = "n") # to remove numbers 0, 5, 10... 

# add the line for the low site 
lines(density(h_low_hours, from = 0, to = 24), 
      col = "grey60", 
      lwd = 2, 
      lty = 2)

# create personalized axis with the hours
axis(1, at = c(0, 6, 12, 18, 24), 
     labels = c("0:00", "6:00", "12:00", "18:00", "24:00"))

# create the legend 
legend("topleft",
       legend = c("High Human Presence", "Low Human Presence"),
       col = c("black", "grey60"),
       lwd = 2,
       lty = c(1, 2),
       bty = "n")

