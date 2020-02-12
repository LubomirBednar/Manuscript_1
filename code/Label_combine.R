# script for combining all clean datasets into one
library(httr)
library(Rmisc)
library(RCurl)

# load in weight and oocysts
P3_weight <- "https://raw.githubusercontent.com/LubomirBednar/Manuscript_1/master/clean_data/P3_112019_Eim_weight_complete.csv"
P3_weight <- read.csv(text = getURL(P3_weight))
