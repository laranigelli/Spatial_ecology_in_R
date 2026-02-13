# change the directory
setwd("C:/Users/A315-59-530X/Desktop/uni/GCE/secondo anno/SPATIAL ECOLOGY IN R/EXAM")
# check directory 
getwd()
# open the packages 
library(overlap) #
library(lubridate) #

# upload the dataset
mydata<-read.csv("UrbanDataset_Read-Only.csv",sep=";")
head(mydata)

# to convert time in radiants: first in a number from 0 to 1 (fraction of the day) and then in radiants
mydata$circtime <- as.numeric(hms(mydata$Hour))/86400 * 2*pi
mydata <- mydata[!is.na(mydata$circtime), ]  # to eliminate the lines without a value for the hour

# hms() takes the column into my text and changes it into a temporary object made of hours, minutes and secodns
# as.numeric() transforms that object into total seconds passed from midnight 
# /86400 is the total amounts of seconds in 24 hours. by dividing the seconds for the total seconds of the day we obtin a number from 0 to 1

# in spatial ecology time is not linear but it is a cirle. a complete circle is made by 2pi radiants so by multiplying the fraction of the day that we obtained previously we obtain a circular time. 
# defiinition of high/low human presence sites 

# we count how many "human" records we have for every site in the dataset
human_counts <- table(mydata$Site[mydata$Sps == "Human"])
# i use only the sites where in the column Sps, HUman is written
# table function takes the list of "Humans" and counts how many times the voice appeares in every site.
# human_counts is used to create an object, a table of frequencies. 
# == os is a test for equality

# now we create a list of the "High Sites" by chosing those with more than 25 human observations.
high_human_sites <- names(human_counts[human_counts > 25])
# the condition is that human counts are higher than 25
# the function names is used because we only need names in the table human_counts that contains both numbers and names

# we can add a column to the dataset (mydata$Impact) to distinguish the low and high impact 
mydata$Impact <- ifelse(mydata$Site %in% high_human_sites, "High", "Low")
# ifelse function is used to control every line of the dataset and it is based on a test: if the test is true in this case, in the column it will be written High; if the test is false, it will be written Low. 
# i use the function %in% to map the classification of the anthropic impact on every single observation from the dataset, by distinghuishing the records accorgind to the belonging of the sites to the High impact category previously defined.

# now we selct the data for the RedFox by filtering 
fox <- mydata[mydata$Sps == "RedFox", ]
# it is used to create a mini dataset that only contains the lines related to the fox by temporarly eliminating all the other species. 
# the new object created is called fox and the data are obtained from the original dataset. 
# [,] suggests that the lines before the , are kept and the colums after the , are kept
# == controls that it is exactly equal to RedFox, the name in the datset

# now we divide the foxes into two groups, those present in high sites and those present in low sites
fox_high <- fox[fox$Impact == "High", ]
fox_low <- fox[fox$Impact == "Low", ]

# we extract only the vectors for the time by 
fox_high_time <- fox_high$circtime
fox_low_time <- fox_low$circtime

# ! is the NOT symbol
# is.na is a function that controls every element of the vector and answers true if the value is missing (NA) and false if there is a number 
# !is.na() we invert the result, true when the result is present, false when it is missing 
# [] to select the elements for which the condition inside it is true 

# graphs

# density plot for foxes in high impact sites 
densityPlot(fox_high_time, main="Red Fox activity - High Human Presence")

# density plot for foxes in low impact sites 
densityPlot(fox_low_time, main="Red Fox Activity - Low Human Presence")

# overlap plot to compare them 
overlapPlot(fox_high_time, fox_low_time, 
            main="Comparison Red Fox Activity: High vs Low Impact",
            xlab="Time of the day (Hours)",
            linecol=c("red", "blue"), # red=High, Blue=Low
            olapcol="lightgrey", # to underline di overlap area
            xscale=24) # to convert radiants into hours 
# we add a legend 
legend("topright", c("High Human Presence", "Low Human Presence"), 
       lty=1, col=c("red", "blue"), bty='n')

# topright is the position of the legend
# c () is the text, we use it to create a vector of words
#lty=1 is the Line Type, 1 is a continous line
# col=c() it's the colors
#bty='n' is the Box Type, 'n' stands for none. it eliminates the black rectangule across the legend.

# numeric estimate of the overlap
overlap_index <- overlapEst(fox_high_time, fox_low_time, type="Dhat4")
print(overlap_index)
# this values goes from 0 (no overlap) to 1 (total overlap, same activity profiles)
# 0.85 gives a very high overlap. despite of human presence, foxes in high impact sites keeps having similar activities to those in low impact sites. no drastic shift in times. 
# probably because foxes are already avoiding humans without changing their activities since it is mainly crepuscolar/nocturnal or they are used to humans.
# type="Dhat4" is the most precise estimator when the number of observations are >50
