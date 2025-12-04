# Example Markdown code for the exam (in markdown we use the hashtag for the header )

## how to import external data in R

The pacakges needed are the following

```r
library(terra)
library(imageRy)
```
working directory: from which we take the data and save them
First of all it is important to set the working directory by: 
```r
setwd("C:/Users/A315-59-530X/Desktop/uni/GCE/secondo anno/SPATIAL ECOLOGY IN R")
# to check if the working directory is properly set 
getwd()
```

Once the data to be used has been put in the working directory we can upload it to R by 
```r
group<-rast("image.JPG")
```
# Visualize the data
In order to visualize data we will use RGB scheme:
```r
group<-flip(group)
im.plotRGB(group,r=1,g=2,b=3)
```

Exporting the result of the previous code is done by 
```r
png("groupphoto.png")
im.plotRGB(group,r=1,g=2,b=3)
dev.off()
```

The output is then: 

<img width="480" height="480" alt="groupphoto" src="https://github.com/user-attachments/assets/61031738-390f-4b73-8447-f65136be4ac6" />

Changing layers inside the RGB scheme is done by: 
```r
png("groupphoto2.png")
im.plotRGB(group,r=2,g=1,b=3)
dev.off()
```

The result of layer inversion will be a false color like: 

<img width="480" height="480" alt="groupphoto2" src="https://github.com/user-attachments/assets/a5e177c0-7f6d-4757-a84f-e08847bd016f" />
