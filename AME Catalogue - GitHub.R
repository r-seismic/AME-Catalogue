###############################################################################

#PLEASE FOR GOD'S SAKE READ THE README

#VARIABLES YOU SHOULD EDIT

#Catalogue prefix (what goes in front of the object's numerical designation)
#For example, if you put "ROFL", you would get names like ROFL-1HM and ROFL-S1FII
#Prefix is set to "AME" by default, replace text inside quotes
prefix <- "AME"

#Sets working directory
#This program will not work unless you edit this line to point to the directrory where your EDDiscovery spreadsheets are
#This directory is where the program will write exported spreadsheets to as well
#Replace text inside quotes
setwd("C:/Users/your-username/etc/etc/etc/etc")

###############################################################################

#Loads Data from CSVs exported from ED Discovery
content_planets <- read.csv("AME Catalogue Planets.csv")
content_stars <- read.csv("AME Catalogue Stars.csv")

#Reads number of rows in spreadsheets
data_entries_s <- nrow(content_stars)
data_entries_p <- nrow(content_planets)

#Draw The Progress Bar
pb <- winProgressBar(title = "AME Catalogue", label = "Initializing ", min = 0, max = 100, width = 300)

#Assigns AME Catalogue Name to Each Entry
#(Change Number After Colon to Match the Number of Entries in Each CSV)
results_planets <- NA
for (i in 1:data_entries_p) {
    results_planets[i] <- paste(prefix, "-", i, sep="")
} 
content_planets$CatRef <- paste(results_planets, content_planets$PlanetClass, sep = "")

results_stars <- NA
for (i in 1:data_entries_s) {
  results_stars[i] <- paste(prefix, "-S", i, sep = "")
}
content_stars$CatRef <- paste(results_stars, content_stars$StarType, content_stars$Luminosity, sep = "")

setWinProgressBar(pb, 5, label = "Writing Object Types 5% Total Completion ")

#Substitutes Planet / Star Class for AME Catalogue Abbreviation
content_planets$CatRef <- gsub("High Metal Content Body", "HM", content_planets$CatRef)
content_planets$CatRef <- gsub("Gas Giant With Ammonia Based Life", "GGWAL", content_planets$CatRef)
content_planets$PlanetClass <- gsub("Gas Giant With Ammonia Based Life", "Sudarsky Gas Giant With Life", content_planets$PlanetClass)
content_planets$PlanetClass <- gsub("Gas Giant With Water Based Life", "Sudarsky Gas Giant With Life", content_planets$PlanetClass)
content_planets$CatRef <- gsub("Rocky Body", "R", content_planets$CatRef)
content_planets$CatRef <- gsub("Metal Rich Body", "MR", content_planets$CatRef)
content_planets$CatRef <- gsub("Icy Body", "I", content_planets$CatRef)
content_planets$CatRef <- gsub("Water World", "W", content_planets$CatRef)
content_planets$CatRef <- gsub("Sudarsky Class I Gas Giant", "S1GG", content_planets$CatRef)
content_planets$CatRef <- gsub("Sudarsky Class III Gas Giant", "S3GG", content_planets$CatRef)
content_planets$CatRef <- gsub("Earthlike Body", "E", content_planets$CatRef)
content_planets$CatRef <- gsub("Sudarsky Class II Gas Giant", "S2GG", content_planets$CatRef)
content_planets$CatRef <- gsub("Sudarsky Class V Gas Giant", "S5GG", content_planets$CatRef)
content_planets$CatRef <- gsub("Sudarsky Class IV Gas Giant", "S4GG", content_planets$CatRef)
content_planets$CatRef <- gsub("Gas Giant With Water Based Life", "GGWL", content_planets$CatRef)
content_planets$CatRef <- gsub("Rocky Ice Body", "RI", content_planets$CatRef)
content_planets$CatRef <- gsub("Ammonia World", "AW", content_planets$CatRef)
content_stars$StarType <- gsub("A_BlueWhiteSuperGiant", "A", content_stars$StarType)
content_stars$CatRef <- gsub("A_BlueWhiteSuperGiant", "AO", content_stars$CatRef)
content_stars$StarType <- gsub("TTS", "T", content_stars$StarType)
content_stars$StarType <- gsub("WC", "W", content_stars$StarType)
content_stars$StarType <- gsub("N", "DA", content_stars$StarType)
content_stars$CatRef <- gsub("N", "DA", content_stars$CatRef)

setWinProgressBar(pb, 10, label = "Writing Proper Names 10% Total Completion ")

###############################################################################

# MORE VARIABLES YOU SHOULD EDIT

#Below is where you put all your custom names for celestial objects
#The format should be as follows, each entry on a seperate line:
#content_planets$CatRef <- gsub("NAME LISTED UNDER CatRef COLUMN", "CUSTOM NAME", content_planets$CatRef)
#For stars, put content_stars$CatRef <- gsub("NAME LISTED UNDER CatRef COLUMN", "CUSTOM NAME", content_stars$CatRef)
#I would highly recommend running the entire program first (ctrl+shift+s) so you can look up the new catalogue name after it's been generated

#Here's an example (don't run the program with this example, it'll throw an error if you do)
content_planets$CatRef <- gsub("AME-37S3GG", "Jameson's Planet", content_planets$CatRef)

###############################################################################

setWinProgressBar(pb, 15, label = "Merging Data 15% Total Completion ")

#Merges Data for Planets and Stars Into the Same CSV
content_combined <- merge(content_planets, content_stars, all = TRUE)
content_final <- content_combined[,c(15, 1:66)]
content_final$CatRef.1 <- NULL

setWinProgressBar(pb, 20, label = "Converting Units 20% Total Completion ")

#Converts Units to Match ED Discovery Entries
content_final$Radius <- content_final$Radius / 1000
content_final$SurfacePressure <- content_final$SurfacePressure / 100000
content_final$RotationPeriod <- content_final$RotationPeriod / 365 / 24 / 10
content_final$OrbitalPeriod <- content_final$OrbitalPeriod / 365 / 236.95
content_final$SurfaceTemperature <- content_final$SurfaceTemperature - 273.15
content_final$SemiMajorAxis <- content_final$SemiMajorAxis / 149597900000

#Forces Standard Notation Instead of Scientific Notation
options(scipen=999)

setWinProgressBar(pb, 25, label = "Rounding Numbers 25% Total Completion ")

#Rounds Numbers
content_final$DistanceFromArrivalLS <- round(content_final$DistanceFromArrivalLS, digits = 2)
content_final$Radius <- round(content_final$Radius, digits = 2)
content_final$RotationPeriod <- round(content_final$RotationPeriod, digits = 8)
content_final$SurfaceTemperature <- round(content_final$SurfaceTemperature, digits = 2)
content_final$SemiMajorAxis <- round(content_final$SemiMajorAxis, digits = 2)
content_final$Eccentricity <- round(content_final$Eccentricity, digits = 4)
content_final$OrbitalInclination <- round(content_final$OrbitalInclination, digits = 4)
content_final$Periapsis <- round(content_final$Periapsis, digits = 2)
content_final$OrbitalPeriod <- round(content_final$OrbitalPeriod, digits = 4)
content_final$AxialTilt <- round(content_final$AxialTilt, digits = 4)
content_final$Iron <- round(content_final$Iron, digits = 2)
content_final$Silicates <- round(content_final$Silicates, digits = 2)
content_final$SulphurDioxide <- round(content_final$SulphurDioxide, digits = 2)
content_final$CarbonDioxide <- round(content_final$CarbonDioxide, digits = 2)
content_final$Nitrogen <- round(content_final$Nitrogen, digits = 2)
content_final$Oxygen <- round(content_final$Oxygen, digits = 2)
content_final$Water <- round(content_final$Water, digits = 2)
content_final$Argon <- round(content_final$Argon, digits = 2)
content_final$Ammonia <- round(content_final$Ammonia, digits = 2)
content_final$Methane <- round(content_final$Methane, digits = 2)
content_final$Hydrogen <- round(content_final$Hydrogen, digits = 2)
content_final$Helium <- round(content_final$Helium, digits = 2)
content_final$SurfaceGravity <- round(content_final$SurfaceGravity, digits = 2)
content_final$SurfacePressure <- round(content_final$SurfacePressure, digits = 2)
content_final$EarthMasses <- round(content_final$EarthMasses, digits = 6)
content_final$Carbon <- round(content_final$Carbon, digits = 2)
content_final$Iron.1 <- round(content_final$Iron.1, digits = 2)
content_final$Nickel <- round(content_final$Nickel, digits = 2)
content_final$Phosphorus <- round(content_final$Phosphorus, digits = 2)
content_final$Sulphur <- round(content_final$Sulphur, digits = 2)
content_final$Arsenic <- round(content_final$Arsenic, digits = 2)
content_final$Chromium <- round(content_final$Chromium, digits = 2)
content_final$Germanium <- round(content_final$Germanium, digits = 2)
content_final$Manganese <- round(content_final$Manganese, digits = 2)
content_final$Vanadium <- round(content_final$Vanadium, digits = 2)
content_final$Selenium <- round(content_final$Selenium, digits = 2)
content_final$Zinc <- round(content_final$Zinc, digits = 2)
content_final$Zirconium <- round(content_final$Zirconium, digits = 2)
content_final$Cadmium <- round(content_final$Cadmium, digits = 2)
content_final$Mercury <- round(content_final$Mercury, digits = 2)
content_final$Molybdenum <- round(content_final$Molybdenum, digits = 2)
content_final$Niobium <- round(content_final$Niobium, digits = 2)
content_final$Tin <- round(content_final$Tin, digits = 2)
content_final$Tungsten <- round(content_final$Tungsten, digits = 2)
content_final$Antimony <- round(content_final$Antimony, digits = 2)
content_final$Polonium <- round(content_final$Polonium, digits = 2)
content_final$Ruthenium <- round(content_final$Ruthenium, digits = 2)
content_final$Technetium <- round(content_final$Technetium, digits = 2)
content_final$Tellurium <- round(content_final$Tellurium, digits = 2)
content_final$Yttrium <- round(content_final$Yttrium, digits = 2)
content_final$StellarMass <- round(content_final$StellarMass, digits = 6)
content_final$AbsoluteMagnitude <- round(content_final$AbsoluteMagnitude, digits = 2)
content_final$Age.MY <- round(content_final$Age.MY, digits = 2)
content_final$OrbitalInclination <- round(content_final$OrbitalInclination, digits = 2)

setWinProgressBar(pb, 30, label = "Writing CSV 30% Total Completion ")

#Writes Everything Into a New CSV
write.csv(content_final, file = "AME Catalogue (Final).csv")

#Transfers Data Into a New CSV with Units
content_final_gdrive <- content_final

setWinProgressBar(pb, 40, label = "Adding Units to Entries 40% Total Completion ")

#Adds Units on the End of Every Number
content_final_gdrive$Radius <- paste(content_final_gdrive$Radius, " km")
content_final_gdrive$RotationPeriod <- paste(content_final_gdrive$RotationPeriod, " Days")
content_final_gdrive$OrbitalPeriod <- paste(content_final_gdrive$OrbitalPeriod, " Days")
content_final_gdrive$SurfaceTemperature <- paste(content_final_gdrive$SurfaceTemperature, " °C")
content_final_gdrive$SemiMajorAxis <- paste(content_final_gdrive$SemiMajorAxis, " AU")
content_final_gdrive$Eccentricity <- paste(content_final_gdrive$Eccentricity, "°")
content_final_gdrive$OrbitalInclination <- paste(content_final_gdrive$OrbitalInclination, "°")
content_final_gdrive$Periapsis <- paste(content_final_gdrive$Periapsis, "°")
content_final_gdrive$AxialTilt <- paste(content_final_gdrive$AxialTilt, "°")
content_final_gdrive$SurfaceGravity <- paste(content_final_gdrive$SurfaceGravity, "G")
content_final_gdrive$SurfacePressure <- paste(content_final_gdrive$SurfacePressure, " atm")
content_final_gdrive$StellarMass <- paste(content_final_gdrive$StellarMass, " Sol Masses")
content_final_gdrive$Age.MY <- paste(content_final_gdrive$Age.MY, " Million Years")
content_final_gdrive$Estimated.Value <- paste(content_final_gdrive$Estimated.Value, " Credits")
content_final_gdrive$DistanceFromArrivalLS <- paste(content_final_gdrive$DistanceFromArrivalLS, " ls")
content_final_gdrive$Iron <- paste(content_final_gdrive$Iron, "%")
content_final_gdrive$Silicates <- paste(content_final_gdrive$Silicates, "%")
content_final_gdrive$SulphurDioxide <- paste(content_final_gdrive$SulphurDioxide, "%")
content_final_gdrive$CarbonDioxide <- paste(content_final_gdrive$CarbonDioxide, "%")
content_final_gdrive$Nitrogen <- paste(content_final_gdrive$Nitrogen, "%")
content_final_gdrive$Oxygen <- paste(content_final_gdrive$Oxygen, "%")
content_final_gdrive$Water <- paste(content_final_gdrive$Water, "%")
content_final_gdrive$Argon <- paste(content_final_gdrive$Argon, "%")
content_final_gdrive$Ammonia <- paste(content_final_gdrive$Ammonia, "%")
content_final_gdrive$Methane <- paste(content_final_gdrive$Methane, "%")
content_final_gdrive$Hydrogen <- paste(content_final_gdrive$Hydrogen, "%")
content_final_gdrive$Helium <- paste(content_final_gdrive$Helium, "%")
content_final_gdrive$EarthMasses <- paste(content_final_gdrive$EarthMasses, " Earth Masses")
content_final_gdrive$Carbon <- paste(content_final_gdrive$Carbon, "%")
content_final_gdrive$Iron.1 <- paste(content_final_gdrive$Iron.1, "%")
content_final_gdrive$Nickel <- paste(content_final_gdrive$Nickel, "%")
content_final_gdrive$Phosphorus <- paste(content_final_gdrive$Phosphorus, "%")
content_final_gdrive$Sulphur <- paste(content_final_gdrive$Sulphur, "%")
content_final_gdrive$Arsenic <- paste(content_final_gdrive$Arsenic, "%")
content_final_gdrive$Chromium <- paste(content_final_gdrive$Chromium, "%")
content_final_gdrive$Germanium <- paste(content_final_gdrive$Germanium, "%")
content_final_gdrive$Manganese <- paste(content_final_gdrive$Manganese, "%")
content_final_gdrive$Vanadium <- paste(content_final_gdrive$Vanadium, "%")
content_final_gdrive$Selenium <- paste(content_final_gdrive$Selenium, "%")
content_final_gdrive$Zinc <- paste(content_final_gdrive$Zinc, "%")
content_final_gdrive$Zirconium <- paste(content_final_gdrive$Zirconium, "%")
content_final_gdrive$Cadmium <- paste(content_final_gdrive$Cadmium, "%")
content_final_gdrive$Mercury <- paste(content_final_gdrive$Mercury, "%")
content_final_gdrive$Molybdenum <- paste(content_final_gdrive$Molybdenum, "%")
content_final_gdrive$Niobium <- paste(content_final_gdrive$Niobium, "%")
content_final_gdrive$Tin <- paste(content_final_gdrive$Tin, "%")
content_final_gdrive$Tungsten <- paste(content_final_gdrive$Tungsten, "%")
content_final_gdrive$Antimony <- paste(content_final_gdrive$Antimony, "%")
content_final_gdrive$Polonium <- paste(content_final_gdrive$Polonium, "%")
content_final_gdrive$Ruthenium <- paste(content_final_gdrive$Ruthenium, "%")
content_final_gdrive$Technetium <- paste(content_final_gdrive$Technetium, "%")
content_final_gdrive$Tellurium <- paste(content_final_gdrive$Tellurium, "%")
content_final_gdrive$Yttrium <- paste(content_final_gdrive$Yttrium, "%")

#Writes Everything Into New CSV for Uploading to Google Drive
write.csv(content_final_gdrive, file = "AME Catalogue (Final with Units).csv")
setWinProgressBar(pb, 45, label = "Preparing to Calculate Z-Scores 45% Total Completion ")

###############################################################################

#Setup to check z-scores

content_stars_final <- NA
content_stars_final <- subset(content_final, content_final$StellarMass > 0)
content_planets_final <- subset(content_final, is.na(content_final$StellarMass == TRUE))
Stars_K <- "CatRef"
Stars_A <- "CatRef"
Stars_C <- "CatRef"
Stars_B <- "CatRef"
Stars_F <- "CatRef"
Stars_G <- "CatRef"
Stars_BlackHole <- "CatRef"
Stars_L <- "CatRef"
Stars_M <- "CatRef"
Stars_CompactStars <- "CatRef"
Stars_O <- "CatRef"
Stars_Protostars <- "CatRef"
Stars_Y <- "CatRef"
Stars_W <- "CatRef"
Planets_HM <- "CatRef"
Planets_AW <- "CatRef"
Planets_E <- "CatRef"
Planets_RI <- "CatRef"
Planets_R <- "CatRef"
Planets_I <- "CatRef"
Planets_MR <- "CatRef"
Planets_W <- "CatRef"
Planets_S1GG <- "CatRef"
Planets_S2GG <- "CatRef"
Planets_S3GG <- "CatRef"
Planets_S4GG <- "CatRef"
Planets_S5GG <- "CatRef"
Planets_GGWL <- "CatRef"

setWinProgressBar(pb, 50, label = "Calculating Z-Scores for Stars 50% Total Completion ")

#Check z-scores for attributes of...

#...Class K Stars
omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "K"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "K"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "K") - avg)/omega
Stars_K$Radius_Zsc <- zsc
Stars_K <- as.data.frame(Stars_K)
Stars_K[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "K")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "K"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "K"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "K") - avg)/omega
Stars_K$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "K"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "K"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "K") - avg)/omega
Stars_K$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "K"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "K"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "K") - avg)/omega
Stars_K$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "K"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "K"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "K") - avg)/omega
Stars_K$Surface_Temperature_Zsc <- zsc

content_stars_final$abs_rot_period <- abs(content_stars_final$RotationPeriod)
content_planets_final$abs_rot_period <- abs(content_planets_final$RotationPeriod)

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "K"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "K"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "K") - avg)/omega
Stars_K$Rotation_Period_Zsc <- zsc

#...Class A Stars
omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "A"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "A"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "A") - avg)/omega
Stars_A$Radius_Zsc <- zsc
Stars_A <- as.data.frame(Stars_A)
Stars_A[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "A")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "A"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "A"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "A") - avg)/omega
Stars_A$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "A"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "A"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "A") - avg)/omega
Stars_A$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "A"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "A"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "A") - avg)/omega
Stars_A$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "A"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "A"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "A") - avg)/omega
Stars_A$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "A"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "A"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "A") - avg)/omega
Stars_A$Rotation_Period_Zsc <- zsc

#...Class B Stars
omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "B"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "B"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "B") - avg)/omega
Stars_B$Radius_Zsc <- zsc
Stars_B <- as.data.frame(Stars_B)
Stars_B[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "B")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "B"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "B"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "B") - avg)/omega
Stars_B$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "B"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "B"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "B") - avg)/omega
Stars_B$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "B"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "B"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "B") - avg)/omega
Stars_B$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "B"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "B"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "B") - avg)/omega
Stars_B$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "B"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "B"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "B") - avg)/omega
Stars_B$Rotation_Period_Zsc <- zsc

#...Class C Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "C"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "C"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "C") - avg)/omega
Stars_C$Radius_Zsc <- zsc
Stars_C <- as.data.frame(Stars_C)
Stars_C[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "C")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "C"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "C"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "C") - avg)/omega
Stars_C$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "C"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "C"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "C") - avg)/omega
Stars_C$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "C"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "C"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "C") - avg)/omega
Stars_C$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "C"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "C"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "C") - avg)/omega
Stars_C$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "C"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "C"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "C") - avg)/omega
Stars_C$Rotation_Period_Zsc <- zsc

#...Class F Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "F"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "F"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "F") - avg)/omega
Stars_F$Radius_Zsc <- zsc
Stars_F <- as.data.frame(Stars_F)
Stars_F[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "F")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "F"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "F"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "F") - avg)/omega
Stars_F$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "F"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "F"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "F") - avg)/omega
Stars_F$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "F"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "F"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "F") - avg)/omega
Stars_F$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "F"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "F"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "F") - avg)/omega
Stars_F$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "F"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "F"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "F") - avg)/omega
Stars_F$Rotation_Period_Zsc <- zsc

#...Class G Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "G"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "G"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "G") - avg)/omega
Stars_G$Radius_Zsc <- zsc
Stars_G <- as.data.frame(Stars_G)
Stars_G[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "G")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "G"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "G"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "G") - avg)/omega
Stars_G$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "G"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "G"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "G") - avg)/omega
Stars_G$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "G"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "G"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "G") - avg)/omega
Stars_G$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "G"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "G"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "G") - avg)/omega
Stars_G$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "G"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "G"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "G") - avg)/omega
Stars_G$Rotation_Period_Zsc <- zsc

#...Black Holes

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "H"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "H"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "H") - avg)/omega
Stars_BlackHole$Radius_Zsc <- zsc
Stars_BlackHole <- as.data.frame(Stars_BlackHole)
Stars_BlackHole[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "H")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "H"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "H"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "H") - avg)/omega
Stars_BlackHole$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "H"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "H"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "H") - avg)/omega
Stars_BlackHole$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "H"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "H"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "H") - avg)/omega
Stars_BlackHole$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "H"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "H"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "H") - avg)/omega
Stars_BlackHole$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "H"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "H"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "H") - avg)/omega
Stars_BlackHole$Rotation_Period_Zsc <- zsc

#...Class L Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "L"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "L"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "L") - avg)/omega
Stars_L$Radius_Zsc <- zsc
Stars_L <- as.data.frame(Stars_L)
Stars_L[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "L")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "L"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "L"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "L") - avg)/omega
Stars_L$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "L"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "L"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "L") - avg)/omega
Stars_L$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "L"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "L"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "L") - avg)/omega
Stars_L$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "L"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "L"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "L") - avg)/omega
Stars_L$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "L"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "L"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "L") - avg)/omega
Stars_L$Rotation_Period_Zsc <- zsc

#...Class M Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "M"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "M"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "M") - avg)/omega
Stars_M$Radius_Zsc <- zsc
Stars_M <- as.data.frame(Stars_M)
Stars_M[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "M")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "M"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "M"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "M") - avg)/omega
Stars_M$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "M"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "M"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "M") - avg)/omega
Stars_M$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "M"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "M"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "M") - avg)/omega
Stars_M$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "M"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "M"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "M") - avg)/omega
Stars_M$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "M"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "M"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "M") - avg)/omega
Stars_M$Rotation_Period_Zsc <- zsc

#...Compact Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "DA"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "DA"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "DA") - avg)/omega
Stars_CompactStars$Radius_Zsc <- zsc
Stars_CompactStars <- as.data.frame(Stars_CompactStars)
Stars_CompactStars[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "DA")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "DA"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "DA"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "DA") - avg)/omega
Stars_CompactStars$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "DA"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "DA"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "DA") - avg)/omega
Stars_CompactStars$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "DA"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "DA"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "DA") - avg)/omega
Stars_CompactStars$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "DA"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "DA"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "DA") - avg)/omega
Stars_CompactStars$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "DA"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "DA"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "DA") - avg)/omega
Stars_CompactStars$Rotation_Period_Zsc <- zsc

#...Class O Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "O"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "O"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "O") - avg)/omega
Stars_O$Radius_Zsc <- zsc
Stars_O <- as.data.frame(Stars_O)
Stars_O[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "O")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "O"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "O"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "O") - avg)/omega
Stars_O$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "O"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "O"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "O") - avg)/omega
Stars_O$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "O"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "O"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "O") - avg)/omega
Stars_O$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "O"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "O"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "O") - avg)/omega
Stars_O$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "O"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "O"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "O") - avg)/omega
Stars_O$Rotation_Period_Zsc <- zsc

#...Protostars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "T"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "T"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "T") - avg)/omega
Stars_Protostars$Radius_Zsc <- zsc
Stars_Protostars <- as.data.frame(Stars_Protostars)
Stars_Protostars[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "T")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "T"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "T"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "T") - avg)/omega
Stars_Protostars$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "T"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "T"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "T") - avg)/omega
Stars_Protostars$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "T"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "T"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "T") - avg)/omega
Stars_Protostars$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "T"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "T"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "T") - avg)/omega
Stars_Protostars$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "T"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "T"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "T") - avg)/omega
Stars_Protostars$Rotation_Period_Zsc <- zsc

#...Class W Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "W"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "W"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "W") - avg)/omega
Stars_W$Radius_Zsc <- zsc
Stars_W <- as.data.frame(Stars_W)
Stars_W[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "W")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "W"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "W"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "W") - avg)/omega
Stars_W$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "W"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "W"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "W") - avg)/omega
Stars_W$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "W"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "W"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "W") - avg)/omega
Stars_W$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "W"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "W"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "W") - avg)/omega
Stars_W$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "W"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "W"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "W") - avg)/omega
Stars_W$Rotation_Period_Zsc <- zsc

#...Class Y Stars

omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == "Y"))
avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == "Y"))
zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == "Y") - avg)/omega
Stars_Y$Radius_Zsc <- zsc
Stars_Y <- as.data.frame(Stars_Y)
Stars_Y[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == "Y")

omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == "Y"))
avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == "Y"))
zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == "Y") - avg)/omega
Stars_Y$Mass_Zsc <- zsc

omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "Y"))
avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "Y"))
zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == "Y") - avg)/omega
Stars_Y$Absolute_Magnitude_Zsc <- zsc

omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == "Y"))
avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == "Y"))
zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == "Y") - avg)/omega
Stars_Y$Age_Zsc <- zsc

omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "Y"))
avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "Y"))
zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == "Y") - avg)/omega
Stars_Y$Surface_Temperature_Zsc <- zsc

omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "Y"))
avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "Y"))
zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == "Y") - avg)/omega
Stars_Y$Rotation_Period_Zsc <- zsc

#...HM Planets

setWinProgressBar(pb, 70, label = "Calculating Z-Scores for Planets 70% Total Completion ")

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$Radius_Zsc <- zsc
Planets_HM <- as.data.frame(Planets_HM)
Planets_HM[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "High Metal Content Body")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$SurfacePressure_Zsc <- zsc

omega <- sd(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsCarbon_Zsc <- zsc

omega <- sd(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsIron_Zsc <- zsc

omega <- sd(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsNickel_Zsc <- zsc

omega <- sd(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsPhosphorus_Zsc <- zsc

omega <- sd(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsSulphur_Zsc <- zsc

omega <- sd(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsArsenic_Zsc <- zsc

omega <- sd(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsChromium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsGermanium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsManganese_Zsc <- zsc

omega <- sd(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsSelenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsVanadium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsZinc_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsZirconium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsCadmium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsMercury_Zsc <- zsc

omega <- sd(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsMolybdenum_Zsc <- zsc

omega <- sd(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsNiobium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Tin, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsTin_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsTungsten_Zsc <- zsc

omega <- sd(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsAntimony_Zsc <- zsc

omega <- sd(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsPolonium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsRuthenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsTechnetium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsTellurium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "High Metal Content Body"))
avg <- mean(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "High Metal Content Body"))
zsc <- (subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "High Metal Content Body") - avg)/omega
Planets_HM$MineralsYttrium_Zsc <- zsc

#...AW Planets

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$Radius_Zsc <- zsc
Planets_AW <- as.data.frame(Planets_AW)
Planets_AW[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Ammonia World")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Ammonia World"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Ammonia World"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Ammonia World") - avg)/omega
Planets_AW$SurfacePressure_Zsc <- zsc

#...Earthlike Planets

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$Radius_Zsc <- zsc
Planets_E <- as.data.frame(Planets_E)
Planets_E[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Earthlike Body")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Earthlike Body"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Earthlike Body"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Earthlike Body") - avg)/omega
Planets_E$SurfacePressure_Zsc <- zsc

#...Icy Planets

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$Radius_Zsc <- zsc
Planets_I <- as.data.frame(Planets_I)
Planets_I[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Icy Body")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$SurfacePressure_Zsc <- zsc

omega <- sd(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsCarbon_Zsc <- zsc

omega <- sd(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsIron_Zsc <- zsc

omega <- sd(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsNickel_Zsc <- zsc

omega <- sd(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsPhosphorus_Zsc <- zsc

omega <- sd(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsSulphur_Zsc <- zsc

omega <- sd(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsArsenic_Zsc <- zsc

omega <- sd(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsChromium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsGermanium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsManganese_Zsc <- zsc

omega <- sd(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsSelenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsVanadium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsZinc_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsZirconium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsCadmium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsMercury_Zsc <- zsc

omega <- sd(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsMolybdenum_Zsc <- zsc

omega <- sd(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsNiobium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsTin_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsTungsten_Zsc <- zsc

omega <- sd(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsAntimony_Zsc <- zsc

omega <- sd(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsPolonium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsRuthenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsTechnetium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsTellurium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Icy Body"))
avg <- mean(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Icy Body"))
zsc <- (subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Icy Body") - avg)/omega
Planets_I$MineralsYttrium_Zsc <- zsc

#...Metal Rich Planets

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$Radius_Zsc <- zsc
Planets_MR <- as.data.frame(Planets_MR)
Planets_MR[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Metal Rich Body")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$SurfacePressure_Zsc <- zsc

omega <- sd(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsCarbon_Zsc <- zsc

omega <- sd(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsIron_Zsc <- zsc

omega <- sd(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsNickel_Zsc <- zsc

omega <- sd(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsPhosphorus_Zsc <- zsc

omega <- sd(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsSulphur_Zsc <- zsc

omega <- sd(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsArsenic_Zsc <- zsc

omega <- sd(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsChromium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsGermanium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsManganese_Zsc <- zsc

omega <- sd(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsSelenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsVanadium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsZinc_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsZirconium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsCadmium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsMercury_Zsc <- zsc

omega <- sd(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsMolybdenum_Zsc <- zsc

omega <- sd(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsNiobium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsTin_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsTungsten_Zsc <- zsc

omega <- sd(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsAntimony_Zsc <- zsc

omega <- sd(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsPolonium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsRuthenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsTechnetium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsTellurium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Metal Rich Body"))
avg <- mean(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Metal Rich Body"))
zsc <- (subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Metal Rich Body") - avg)/omega
Planets_MR$MineralsYttrium_Zsc <- zsc

#...Rocky Bodies

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$Radius_Zsc <- zsc
Planets_R <- as.data.frame(Planets_R)
Planets_R[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Rocky Body")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$SurfacePressure_Zsc <- zsc

omega <- sd(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsCarbon_Zsc <- zsc

omega <- sd(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsIron_Zsc <- zsc

omega <- sd(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsNickel_Zsc <- zsc

omega <- sd(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsPhosphorus_Zsc <- zsc

omega <- sd(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsSulphur_Zsc <- zsc

omega <- sd(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsArsenic_Zsc <- zsc

omega <- sd(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsChromium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsGermanium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsManganese_Zsc <- zsc

omega <- sd(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsSelenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsVanadium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsZinc_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsZirconium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsCadmium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsMercury_Zsc <- zsc

omega <- sd(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsMolybdenum_Zsc <- zsc

omega <- sd(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsNiobium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsTin_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsTungsten_Zsc <- zsc

omega <- sd(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsAntimony_Zsc <- zsc

omega <- sd(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsPolonium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsRuthenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsTechnetium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsTellurium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Rocky Body"))
avg <- mean(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Rocky Body"))
zsc <- (subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Rocky Body") - avg)/omega
Planets_R$MineralsYttrium_Zsc <- zsc

#...Rocky Ice Planets

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$Radius_Zsc <- zsc
Planets_RI <- as.data.frame(Planets_RI)
Planets_RI[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Rocky Ice Body")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$SurfacePressure_Zsc <- zsc

omega <- sd(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Carbon, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsCarbon_Zsc <- zsc

omega <- sd(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsIron_Zsc <- zsc

omega <- sd(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Nickel, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsNickel_Zsc <- zsc

omega <- sd(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsPhosphorus_Zsc <- zsc

omega <- sd(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsSulphur_Zsc <- zsc

omega <- sd(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsArsenic_Zsc <- zsc

omega <- sd(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Chromium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsChromium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Germanium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsGermanium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Manganese, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsManganese_Zsc <- zsc

omega <- sd(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Selenium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsSelenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsVanadium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Zinc, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsZinc_Zsc <- zsc

omega <- sd(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsZirconium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsCadmium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Mercury, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsMercury_Zsc <- zsc

omega <- sd(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsMolybdenum_Zsc <- zsc

omega <- sd(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Niobium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsNiobium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Tin, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsTin_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsTungsten_Zsc <- zsc

omega <- sd(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Antimony, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsAntimony_Zsc <- zsc

omega <- sd(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Polonium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsPolonium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsRuthenium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Technetium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsTechnetium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsTellurium_Zsc <- zsc

omega <- sd(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Rocky Ice Body"))
avg <- mean(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Rocky Ice Body"))
zsc <- (subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == "Rocky Ice Body") - avg)/omega
Planets_RI$MineralsYttrium_Zsc <- zsc

#...Class I Gas Giants

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$Radius_Zsc <- zsc
Planets_S1GG <- as.data.frame(Planets_S1GG)
Planets_S1GG[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class I Gas Giant") - avg)/omega
Planets_S1GG$SurfacePressure_Zsc <- zsc

#...Class II Gas Giants

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$Radius_Zsc <- zsc
Planets_S2GG <- as.data.frame(Planets_S2GG)
Planets_S2GG[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class II Gas Giant") - avg)/omega
Planets_S2GG$SurfacePressure_Zsc <- zsc

#...Class III Gas Giants

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$Radius_Zsc <- zsc
Planets_S3GG <- as.data.frame(Planets_S3GG)
Planets_S3GG[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class III Gas Giant") - avg)/omega
Planets_S3GG$SurfacePressure_Zsc <- zsc

#...Class IV Gas Giants

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$Radius_Zsc <- zsc
Planets_S4GG <- as.data.frame(Planets_S4GG)
Planets_S4GG[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class IV Gas Giant") - avg)/omega
Planets_S4GG$SurfacePressure_Zsc <- zsc

#...Class V Gas Giants

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$Radius_Zsc <- zsc
Planets_S5GG <- as.data.frame(Planets_S5GG)
Planets_S5GG[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Class V Gas Giant") - avg)/omega
Planets_S5GG$SurfacePressure_Zsc <- zsc

#...Gas Giants With Life

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$Radius_Zsc <- zsc
Planets_GGWL <- as.data.frame(Planets_GGWL)
Planets_GGWL[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Sudarsky Gas Giant With Life") - avg)/omega
Planets_GGWL$SurfacePressure_Zsc <- zsc

#...Water Planets

omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$Radius_Zsc <- zsc
Planets_W <- as.data.frame(Planets_W)
Planets_W[[1]] <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == "Water World")

omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$Mass_Zsc <- zsc

omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$RotationPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$SurfaceTemp_Zsc <- zsc

omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$Eccentricity_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$Inclination_Zsc <- zsc

omega <- sd(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$Periapsis, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$Periapsis_Zsc <- zsc

omega <- sd(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$OrbitalPeriod, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$OrbitalPeriod_Zsc <- zsc

omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$AxialTilt_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$SurfaceGravity_Zsc <- zsc

omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Water World"))
avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Water World"))
zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == "Water World") - avg)/omega
Planets_W$SurfacePressure_Zsc <- zsc

setWinProgressBar(pb, 90, label = "Merging Data 90% Total Completion ")

content_final_zsc <- Reduce(function(...) merge(..., all=TRUE), list(
  Stars_K,
  Stars_A,
  Stars_C,
  Stars_B,
  Stars_F,
  Stars_G,
  Stars_BlackHole,
  Stars_L,
  Stars_M,
  Stars_CompactStars,
  Stars_O,
  Stars_Protostars,
  Stars_Y,
  Stars_W,
  Planets_HM,
  Planets_AW,
  Planets_E,
  Planets_RI,
  Planets_R,
  Planets_I,
  Planets_MR,
  Planets_W,
  Planets_S1GG,
  Planets_S2GG,
  Planets_S3GG,
  Planets_S4GG,
  Planets_S5GG,
  Planets_GGWL
))

setWinProgressBar(pb, 100, label = "Cleaning Up 100% Total Completion ")

volume <- (4/3)*(3.14159265358979323*content_planets_final$Radius^3)
content_planets_final$Density <- ((content_planets_final$EarthMasses*5973600000000000000000000)/volume)/100000000000
volume <- (4/3)*(3.14159265358979323*content_stars_final$Radius^3)
content_stars_final$Density <- ((content_stars_final$StellarMass*1989000000000000000000000000000)/volume)/10000000000000
content_planets_final$Density <- round(content_planets_final$Density, digits = 2)
content_stars_final$Density <- round(content_stars_final$Density, digits = 8)

###############################################################################

#Opens Both CSVs in the RStudio Viewer
View(content_final_zsc)
View(content_planets_final)
View(content_stars_final)
View(content_final)

close(pb)

###############################################################################