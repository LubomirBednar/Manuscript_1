# fecal ELISas P3

library(httr)
library(RCurl)
library(Rmisc)
library(dplyr)
library(ggplot2)
library(tidyr)

##### add clean tables
E1 <- "https://raw.githubusercontent.com/LubomirBednar/Manuscript_1/master/clean_data/P3_112019_Eim_feces_ELISA1_clean.csv"
E1 <- read.csv(text = getURL(E1), sep = ";", header = FALSE)

E1_labels <- "https://raw.githubusercontent.com/LubomirBednar/Manuscript_1/master/clean_data/P3_112019_Eim_feces_ELISA1_labels.csv"
E1_labels <- read.csv(text = getURL(E1_labels), header = FALSE)

# have to melt to long format and merge or reorganize the clean data to long format
