#Draw The Progress Bar
pb <- winProgressBar(title = "AME Catalogue", label = "Initializing ", min = 0, max = 100, width = 300)

#Loads stuff from rvars cache
vars <- read.csv("vars.rvars")
wd <- vars$directory

#Loads Data from CSVs exported from ED Discovery
try(setwd(as.character(wd)))
content_final <- read.csv("AME Catalogue (Final).csv")
content_final$X.1 <- NULL

setWinProgressBar(pb, 50, label = "Loading CSV 50% Total Completion ")

#Subset Data By Properties
#Put properties where it says "PUT PARAMETERS HERE", separated by commas
#AND operator is &, OR operator is |
results <- subset(content_final, PUT PARAMETERS HERE)

setWinProgressBar(pb, 100, label = "Subsetting Data 100% Total Completion ")

View(results)
close(pb)
