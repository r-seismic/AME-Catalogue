#Draw The Progress Bar
pb <- winProgressBar(title = "AME Catalogue", label = "Initializing ", min = 0, max = 100, width = 300)

#Loads Data from CSVs exported from ED Discovery
setwd("C:/Users/every/Google Drive/Windows Mac Share/AME Catalogue")
content_final <- read.csv("AME Catalogue (Final).csv")
content_final$X.1 <- NULL

setWinProgressBar(pb, 50, label = "Loading CSV 50% Total Completion ")

#Subset Data By Properties
#AND operator is &, OR operator is |
results <- subset(content_final, content_final$Age.MY > 0)

setWinProgressBar(pb, 100, label = "Subsetting Data 100% Total Completion ")

View(results)
close(pb)