library(here)
library(rgdal)
library(raster)
library(rerddap)
library(glue)
library(sf)
library(fs)
library(tidyverse)
library(lubridate)
library(infographiqR) # remotes::install_github("marinebon/infographiqR") 
library(onmsR) # remotes::install_github("noaa-onms/onmsR")

print('Starting SST...')
onmsR::calculate_statistics("cinms", "jplMURSST41mday", "sst", "avg-sst_cinms.csv")
print('Starting Chlorophyll...')
onmsR::calculate_statistics("cinms", "nesdisVHNSQchlaMonthly", "chlor_a", "avg-chl_cinms.csv")
print ('Ending')
