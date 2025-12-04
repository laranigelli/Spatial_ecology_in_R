# 🌲 Forest Analysis – Full Markdown Code Template (R Version)

## 1. Introduction
This document shows a complete forest analysis workflow in **R**, including:
- Loading Sentinel-2 data  
- Computing NDVI  
- Visualising vegetation health  
- Forest / non-forest masking  
- Detecting degraded areas  
- Exporting results  

Packages used: `raster`, `terra`, `ggplot2`.

---

## 2. Load Packages

```r
library(raster)
library(terra)
library(ggplot2)

# Load Sentinel-2 Red (B04) and NIR (B08)
red <- raster("B04_red.tif")    # Red band
nir <- raster("B08_nir.tif")    # NIR band
plot(ndvi,
     col = rev(terrain.colors(50)),
     main = "NDVI – Vegetation Health")
ndvi_df <- as.data.frame(ndvi, xy = TRUE)
ggplot(ndvi_df) +
  geom_raster(aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis_c() +
  coord_fixed() +
  labs(title = "NDVI – Vegetation Health", fill = "NDVI")
forest_mask <- ndvi > 0.6
plot(forest_mask, 
     col = c("grey80", "darkgreen"), 
     legend = FALSE,
     main = "Forest Mask (NDVI > 0.6)")
mean_ndvi <- cellStats(ndvi, stat = 'mean', na.rm = TRUE)
max_ndvi  <- cellStats(ndvi, stat = 'max', na.rm = TRUE)
min_ndvi  <- cellStats(ndvi, stat = 'min', na.rm = TRUE)

mean_ndvi
max_ndvi
min_ndvi
degraded <- ndvi < 0.4
plot(degraded,
     col = c("grey90", "red"),
     legend = FALSE,
     main = "Degraded Vegetation Zones (NDVI < 0.4)")
writeRaster(forest_mask, 
            filename = "forest_mask.tif", 
            format = "GTiff", 
            overwrite = TRUE)
