<div align="center">

# Temporal Activity Patterns of Red Fox and Roe Deer Under Human Disturbance

**Lara Nigelli**  
Spatial Ecology in R  
February 2026

</div>

<div align="justify">

# Introduction
The rapid expansion of urban and peri-urban areas has forced wildlife to adapt to fragmented landscapes and high levels of anthropogenic pressure. Temporal activity is a fundamental dimension of an animal's niche, governing foraging, mating, and survival. Understanding when animals are active helps us identify how they share space and resources without direct conflict. Significant shifts in natural rhythms can lead to increased stress, reduced reproductive success, or altered predator-prey dynamics. 
Human presence often acts as a disturbance, pushing wildlife towards nocturnal behaviors to avoid contact. Not all species respond equally to human disturbance; some are urban adapters, capable of persisting in modified landscapes, whereas others respond by temporally avoiding periods of high human activity.

## Study objective
- to quantify overlap measuring the degree of temporal synchronization between wildlife and human activity.
- to evaluate through a comparative analysis the response of the selected species.

</div>

<div align="justify">
  
# Materials and Methods

## Study Area and Dataset

The dataset used in this study was obtained from a camera-trap monitoring program conducted in a human-modified landscape. The data consist of wildlife detections recorded across multiple sampling urban sites around Florence, including both natural and anthropogenic areas. Here you can find the [complete dataset](https://data.mendeley.com/datasets/3htr438mcw/1). 

Each record includes information on species identity, site location, and time of detection. For the present analysis, only records with valid time information were retained.

Human detections were used as a proxy for anthropogenic disturbance. Sites were classified as high-impact when the number of human detections exceeded 25 records, and low-impact otherwise.

Two species were selected for analysis: Red Fox (_Vulpes vulpes_) and Roe Deer (_Capreolus capreolus_), representing species with different ecological and behavioral traits.

</div>

## Packages used in R

The packages needed are the following:

```r
library(overlap)
library(lubridate)
```

<div align="justify">
  
`overlap` provides functions to fit kernel density functions to data on temporal activity patterns of animals and estimate coefficients of overlapping of densities for two species. This package is useful for circular statistics, when treating data as circular. The package allows us to calculate delta estimators to quantify the similarity between two curves.
  
`lubridate` provides functions to work with date-times and time-spans. It is applied for data standardization and time arithmetic allowing to extract time and isolate specific time of day from the date. It allow us to calculate circular math readiness converting time into decimal hours, the first necessary step before converting the data into radians. 
 
</div>

# Data processing 

The dataset was placed in the working directory before running the script. The dataset can be uploaded in R by: 
```r
mydata <- read.csv("UrbanDataset_Read-Only.csv", sep = ";")
```

## Time conversion

In order to convert time in radians, I firstly transformmed it into a fraction of the day (from 0 to 1) and eventually remove the lines where the hour values are missing. 
```r
mydata$circtime <- as.numeric(hms(mydata$Hour)) / 86400 * 2 * pi
mydata <- mydata[!is.na(mydata$circtime), ] 
```

## Definition of High and Low Human Impact

For every site in the dataset, the records for "human" are counted: those with more than 25 human observations are classified in a new created list of the "High Sites"
```r
human_counts <- table(mydata$Site[mydata$Sps == "Human"])
high_human_sites <- names(human_counts[human_counts > 25])
mydata$Impact <- ifelse(mydata$Site %in% high_human_sites, "High", "Low")
```

## Species filters 
From the main dataset I extract by filtering the species I am interested in, the red fox ($n = 502$) and the roe deer ($n = 151$). 
```r
fox <- mydata[mydata$Sps == "RedFox", ]
roedeer <- mydata[mydata$Sps == "RoeDeer", ]
```
Foxes and roe deer are divided into two groups, according if the observation was made in a High Site or a Low Site. 
```r
fox_high <- fox[fox$Impact == "High", ]
fox_low <- fox[fox$Impact == "Low", ]
roedeer_high <- roedeer[roedeer$Impact == "High", ]
roedeer_low <- roedeer[roedeer$Impact == "Low", ]
```

To extract only the time vectors: 
```r
fox_high_time <- fox_high$circtime
fox_low_time <- fox_low$circtime
roedeer_high_time <- roedeer_high$circtime
roedeer_low_time <- roedeer_low$circtime
```

# Statistical Analysis
## Kernel Density
It is based on a non-parametric Density Estimation and it is used to create a smooth curve, providing a more realistic biological model. The density plots for high and low impact sites are produced both for the red fox and for the roe deer. 
```r
densityPlot(fox_high_time, main="Red Fox activity - High Human Presence")
densityPlot(roedeer_high_time, main="Roe Deer activity - High Human Presence")
densityPlot(fox_low_time, main="Red Fox Activity - Low Human Presence")
densityPlot(roedeer_low_time, main="Roe Deer Activity - Low Human Presence")
```
In order to obtain a numeric estimate of the overlap:
```r
overlap_fox_index <- overlapEst(fox_high_time, fox_low_time, type="Dhat4")
overlap_roedeer_index <- overlapEst(roedeer_high_time, roedeer_low_time, type="Dhat4")
```
In this case, the estimator `Dhat4` was applied since the number of observations are >50. 

Finally, the comparision between red fox and human activity and roe deer and human activity was obtained by overlapping the graphs 
```r
overlapPlot(fox_high_time, fox_low_time, 
            main="Comparison Red Fox Activity: High vs Low Human Impact",
            xlab="Time of the day (Hours)",
            linecol=c("red", "blue"),
            olapcol="lightgrey", 
            xscale=24) 

overlapPlot(roedeer_high_time, roedeer_low_time, 
            main="Comparison Roe Deer Activity: High vs Low Human Impact",
            xlab="Time of the day (Hours)",
            linecol=c("red", "blue"),
            olapcol="lightgrey",
            xscale=24)
```

<div align="justify">
  
# Results 
## $\Delta$ values 

The degree of temporal overlap goes from 0 when there is no overlap, to 1 when the overlap is total and the activity profiles are the same. 

For the Red Fox, I obtained a high value (Δ = 0.85), indicating limited temporal shift and stability. Despite human presence, foxes in high impact sites keeps having similar activities to foxes living in wildness. 

In contrast, Roe Deer showed a modest overlap (Δ = 0.51), suggesting greater behavioral adjustment in response to human presence and so a significant temporal shift. The value is due to the low overlap of the curves portions. Roe deer may be so used to human presence to not modify their urban pattern from the wild one.

![Overlap graphs](graphcut.png)


## Objective description of patterns 

The density plots reveal distinct behavioral responses to human presence. 

- Red Fox: the activity curves for both high and low impact sites are largely synchronized, showing a strictly nocturnal and crepuscolar pattern. The peak of activity occurs between 21:00 and 05:00, effectively avoiding the peak of human activity. 
- Roe Deer: its activity patterns show a high degree of similarity between high and low human impact sites. This lack of a significant temporal shift suggests that the population in the study areas has reached a level of habituation to anthropogenic presence. 

# Discussion

## Biological Interpretation and Species Comparison 

The high degree of temporal overlap suggests that both species exhibit significant resilience to human presence in the study area. The results suggest that the natural nocturnal rythm of the red fox, shields it from diurnal human activity, requiring no behavioral shift between high and low impact sites, making it a successful urban adapter.
For the Roe Deer, the absence of a marked difference between the two sites suggests a process of habituation. The current levels of human disturbance are not interpreted as a direct lethal threat, allowing the species to maintain their natural rhythm, including diurnal peaks and to satisfy its ecological requirements throughout the day, even in high pressure areas. The slightly lower overlap for this species indicates that the timing of activity is similar, but the intensity of use varies. 

</div>

### Supplementary Materials
For a detailed view of the individual activity patterns, you can access the full-size PDF plots here:

* [Red Fox Activity - High Impact](redfoxactivity_high.pdf)
* [Red Fox Activity - Low Impact](redfoxactivity_low.pdf)
* [Roe Deer Activity - High Impact](roedeeractivity_high.pdf)
* [Roe Deer Activity - Low Impact](roedeeractivity_low.pdf)

To check for the plot regarding human activity, you can access the full-size PDF plots here:

* [Human Activity](humanacitvityvalidation.pdf)





