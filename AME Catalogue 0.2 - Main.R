###############################################################################
  
#PLEASE FOR GOD'S SAKE READ THE README

#Loads stuff from rvars cache
vars <- read.csv("vars.rvars")
wd <- vars$directory
try(setwd(as.character(wd)))
prefix <- vars$prefix
names_cat <- read.csv("names_cat.rvars")
names_custom <- read.csv("names_custom.rvars")
play_sound <- paste('"', as.character(wd), "/play_sound.bat", '"', sep = "")

#Loads Data from CSV exported from ED Discovery
content <- read.csv("Catalogue Full.csv")

#Reads number of rows in spreadsheets
data_entries <- nrow(content)

#Draw The Progress Bar
pb <- winProgressBar(title = "AME Catalogue", label = "Initializing ", min = 0, max = 100, width = 300)

system(play_sound)
system('cscript say.vbs "Reading Data"')

#Assigns AME Catalogue Name to Each Entry
#(Change Number After Colon to Match the Number of Entries in Each CSV)
results <- NA
for (i in 1:data_entries) {
  if (content$StarType[i] == "") {
    results[i] <- paste(prefix, "-", i, sep="")
  }
  else {
    results[i] <- paste(prefix, "-S", i, sep="")
  }
}
for (i in 1:data_entries) {
  if (content$StarType[i] == "") {
    content$CatRef[i] <- paste(results[i], content$PlanetClass[i], sep = "")
  }
  else {
    content$CatRef[i] <- paste(results[i], content$StarType[i], content$Luminosity[i], sep = "")
  }
}

for (i in 1:data_entries) {
  content$X[i] <- i
}

setWinProgressBar(pb, 5, label = "Writing Object Types 5% Total Completion ")

#Substitutes Planet / Star Class for AME Catalogue Abbreviation
content$CatRef <- gsub("High Metal Content Body", "HM", content$CatRef)
content$CatRef <- gsub("Gas Giant With Ammonia Based Life", "GGWAL", content$CatRef)
content$PlanetClass <- gsub("Gas Giant With Ammonia Based Life", "Sudarsky Gas Giant With Life", content$PlanetClass)
content$PlanetClass <- gsub("Gas Giant With Water Based Life", "Sudarsky Gas Giant With Life", content$PlanetClass)
content$CatRef <- gsub("Rocky Body", "R", content$CatRef)
content$CatRef <- gsub("Metal Rich Body", "MR", content$CatRef)
content$CatRef <- gsub("Icy Body", "I", content$CatRef)
content$CatRef <- gsub("Water World", "W", content$CatRef)
content$CatRef <- gsub("Sudarsky Class I Gas Giant", "S1GG", content$CatRef)
content$CatRef <- gsub("Sudarsky Class III Gas Giant", "S3GG", content$CatRef)
content$CatRef <- gsub("Earthlike Body", "E", content$CatRef)
content$CatRef <- gsub("Sudarsky Class II Gas Giant", "S2GG", content$CatRef)
content$CatRef <- gsub("Helium Rich Gas Giant", "HRGG", content$CatRef)
content$CatRef <- gsub("Water Giant", "WG", content$CatRef)
content$CatRef <- gsub("Sudarsky Class V Gas Giant", "S5GG", content$CatRef)
content$CatRef <- gsub("Sudarsky Class IV Gas Giant", "S4GG", content$CatRef)
content$CatRef <- gsub("Gas Giant With Water Based Life", "GGWL", content$CatRef)
content$CatRef <- gsub("Rocky Ice Body", "RI", content$CatRef)
content$CatRef <- gsub("Ammonia World", "AW", content$CatRef)
content$StarType <- gsub("A_BlueWhiteSuperGiant", "A", content$StarType)
content$CatRef <- gsub("A_BlueWhiteSuperGiant", "AO", content$CatRef)
content$StarType <- gsub("M_RedSuperGiant", "M", content$StarType)
content$CatRef <- gsub("M_RedSuperGiantI", "MO", content$CatRef)
content$StarType <- gsub("TTS", "T", content$StarType)
content$StarType <- gsub("WC", "W", content$StarType)
content$StarType <- gsub("N", "DA", content$StarType)
content$CatRef <- gsub("N", "DA", content$CatRef)

setWinProgressBar(pb, 10, label = "Writing Proper Names 10% Total Completion ")

names_cat$X <- NULL
names_custom$X <- NULL
data_numbers <- nrow(names_cat)
for (i in 1:data_numbers) {
  content$CatRef <- gsub(names_cat$names_cat[i], names_custom$names_custom[i], content$CatRef)
}

###############################################################################

setWinProgressBar(pb, 20, label = "Converting Units 20% Total Completion ")

#Converts Units to Match ED Discovery Entries
content$Radius <- content$Radius / 1000
content$SurfacePressure <- content$SurfacePressure / 100000
content$RotationPeriod <- content$RotationPeriod / 365 / 24 / 10
content$OrbitalPeriod <- content$OrbitalPeriod / 365 / 236.95
content$SurfaceTemperature <- content$SurfaceTemperature - 273.15
content$SemiMajorAxis <- content$SemiMajorAxis / 149597900000

#Forces Standard Notation Instead of Scientific Notation
options(scipen=999)

setWinProgressBar(pb, 25, label = "Rounding Numbers 25% Total Completion ")

#Rounds Numbers
content$DistanceFromArrivalLS <- round(content$DistanceFromArrivalLS, digits = 2)
content$Radius <- round(content$Radius, digits = 2)
content$RotationPeriod <- round(content$RotationPeriod, digits = 8)
content$SurfaceTemperature <- round(content$SurfaceTemperature, digits = 2)
content$SemiMajorAxis <- round(content$SemiMajorAxis, digits = 2)
content$Eccentricity <- round(content$Eccentricity, digits = 4)
content$OrbitalInclination <- round(content$OrbitalInclination, digits = 4)
content$Periapsis <- round(content$Periapsis, digits = 2)
content$OrbitalPeriod <- round(content$OrbitalPeriod, digits = 4)
content$AxialTilt <- round(content$AxialTilt, digits = 4)
content$Iron <- round(content$Iron, digits = 2)
content$Silicates <- round(content$Silicates, digits = 2)
content$SulphurDioxide <- round(content$SulphurDioxide, digits = 2)
content$CarbonDioxide <- round(content$CarbonDioxide, digits = 2)
content$Nitrogen <- round(content$Nitrogen, digits = 2)
content$Oxygen <- round(content$Oxygen, digits = 2)
content$Water <- round(content$Water, digits = 2)
content$Argon <- round(content$Argon, digits = 2)
content$Ammonia <- round(content$Ammonia, digits = 2)
content$Methane <- round(content$Methane, digits = 2)
content$Hydrogen <- round(content$Hydrogen, digits = 2)
content$Helium <- round(content$Helium, digits = 2)
content$SurfaceGravity <- round(content$SurfaceGravity, digits = 2)
content$SurfacePressure <- round(content$SurfacePressure, digits = 2)
content$EarthMasses <- round(content$EarthMasses, digits = 6)
content$Carbon <- round(content$Carbon, digits = 2)
content$Iron.1 <- round(content$Iron.1, digits = 2)
content$Nickel <- round(content$Nickel, digits = 2)
content$Phosphorus <- round(content$Phosphorus, digits = 2)
content$Sulphur <- round(content$Sulphur, digits = 2)
content$Arsenic <- round(content$Arsenic, digits = 2)
content$Chromium <- round(content$Chromium, digits = 2)
content$Germanium <- round(content$Germanium, digits = 2)
content$Manganese <- round(content$Manganese, digits = 2)
content$Vanadium <- round(content$Vanadium, digits = 2)
content$Selenium <- round(content$Selenium, digits = 2)
content$Zinc <- round(content$Zinc, digits = 2)
content$Zirconium <- round(content$Zirconium, digits = 2)
content$Cadmium <- round(content$Cadmium, digits = 2)
content$Mercury <- round(content$Mercury, digits = 2)
content$Molybdenum <- round(content$Molybdenum, digits = 2)
content$Niobium <- round(content$Niobium, digits = 2)
content$Tin <- round(content$Tin, digits = 2)
content$Tungsten <- round(content$Tungsten, digits = 2)
content$Antimony <- round(content$Antimony, digits = 2)
content$Polonium <- round(content$Polonium, digits = 2)
content$Ruthenium <- round(content$Ruthenium, digits = 2)
content$Technetium <- round(content$Technetium, digits = 2)
content$Tellurium <- round(content$Tellurium, digits = 2)
content$Yttrium <- round(content$Yttrium, digits = 2)
content$StellarMass <- round(content$StellarMass, digits = 6)
content$AbsoluteMagnitude <- round(content$AbsoluteMagnitude, digits = 2)
content$Age.MY <- round(content$Age.MY, digits = 2)
content$OrbitalInclination <- round(content$OrbitalInclination, digits = 2)

setWinProgressBar(pb, 30, label = "Writing CSV 30% Total Completion ")

content <- content[,c("CatRef",setdiff(names(content),"CatRef"))]
content <- content[,c("X",setdiff(names(content),"X"))]

#Writes Everything Into a New CSV
write.csv(content, file = "AME Catalogue (Final).csv")

setWinProgressBar(pb, 45, label = "Preparing to Calculate Z-Scores 45% Total Completion ")

###############################################################################

#Setup to check z-scores

content_stars_final <- NA
content_stars_final <- subset(content, content$StellarMass > 0)
content_planets_final <- subset(content, content$StellarMass == 0)
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
Planets_HRGG <- "CatRef"
Planets_WG <- "CatRef"

setWinProgressBar(pb, 50, label = "Calculating Z-Scores for Stars 50% Total Completion ")

Star_Type <- "K"
df <- "Stars_K"

content_stars_final$abs_rot_period <- abs(content_stars_final$RotationPeriod)
content_planets_final$abs_rot_period <- abs(content_planets_final$RotationPeriod)

zs <- function(Star_Type, df) {
  omega <- sd(subset(content_stars_final$Radius, content_stars_final$StarType == Star_Type))
  avg <- mean(subset(content_stars_final$Radius, content_stars_final$StarType == Star_Type))
  zsc <- (subset(content_stars_final$Radius, content_stars_final$StarType == Star_Type) - avg)/omega
  eval(parse(text = paste(df, "$Radius_Zsc <- zsc", sep = "")))
  eval(parse(text = paste(df, " <- as.data.frame(", df, ")", sep = "")))
  eval(parse(text = paste(df, "[[1]] <- subset(content_stars_final$CatRef, content_stars_final$StarType == Star_Type)", sep = "")))
  eval(parse(text = paste(df, "$X <- subset(content_stars_final$X, content_stars_final$StarType == Star_Type)", sep = "")))
  eval(parse(text = paste(df, "$BodyName <- subset(content_stars_final$BodyName, content_stars_final$StarType == Star_Type)", sep = "")))
  
  omega <- sd(subset(content_stars_final$StellarMass, content_stars_final$StarType == Star_Type))
  avg <- mean(subset(content_stars_final$StellarMass, content_stars_final$StarType == Star_Type))
  zsc <- (subset(content_stars_final$StellarMass, content_stars_final$StarType == Star_Type) - avg)/omega
  eval(parse(text = paste(df, "$Mass_Zsc <- zsc", sep = ""))) 

  omega <- sd(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == Star_Type))
  avg <- mean(subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == Star_Type))
  zsc <- (subset(content_stars_final$AbsoluteMagnitude, content_stars_final$StarType == Star_Type) - avg)/omega
  eval(parse(text = paste(df, "$Absolute_Magnitude_Zsc <- zsc", sep = ""))) 
  
  omega <- sd(subset(content_stars_final$Age.MY, content_stars_final$StarType == Star_Type))
  avg <- mean(subset(content_stars_final$Age.MY, content_stars_final$StarType == Star_Type))
  zsc <- (subset(content_stars_final$Age.MY, content_stars_final$StarType == Star_Type) - avg)/omega
  eval(parse(text = paste(df, "$Age_Zsc <- zsc", sep = ""))) 
  
  omega <- sd(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == Star_Type))
  avg <- mean(subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == Star_Type))
  zsc <- (subset(content_stars_final$SurfaceTemperature, content_stars_final$StarType == Star_Type) - avg)/omega
  eval(parse(text = paste(df, "$Surface_Temperature_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == Star_Type))
  avg <- mean(subset(content_stars_final$abs_rot_period, content_stars_final$StarType == Star_Type))
  zsc <- (subset(content_stars_final$abs_rot_period, content_stars_final$StarType == Star_Type) - avg)/omega
  eval(parse(text = paste(df, "$RotationPeriod_Zsc <- zsc", sep = "")))
  
  return(eval(parse(text = paste(df, sep = ""))))
}

setWinProgressBar(pb, 70, label = "Calculating Z-Scores for Planets 70% Total Completion ")

Planet_Class <- "High Metal Content Body"
df_p <- "Planets_HM"

zp <- function(Planet_Class, df_p) {
  omega <- sd(subset(content_planets_final$Radius, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Radius, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Radius, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$Radius_Zsc <- zsc", sep = "")))
  eval(parse(text = paste(df_p, " <- as.data.frame(", df_p, ")", sep = "")))
  eval(parse(text = paste(df_p, "[[1]]", " <- subset(content_planets_final$CatRef, content_planets_final$PlanetClass == Planet_Class)", sep = "")))
  eval(parse(text = paste(df_p, "$X", " <- subset(content_planets_final$X, content_planets_final$PlanetClass == Planet_Class)", sep = "")))
  eval(parse(text = paste(df_p, "$BodyName", " <- subset(content_planets_final$BodyName, content_planets_final$PlanetClass == Planet_Class)", sep = "")))
  
  omega <- sd(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$EarthMasses, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$Mass_Zsc <- zsc", sep = "")))

  omega <- sd(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$abs_rot_period, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$RotationPeriod <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$SurfaceTemperature, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$SurfaceTemp_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Eccentricity, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$Eccentricity_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$OrbitalInclination, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$Inclination_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$AxialTilt, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$AxialTilt_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$SurfaceGravity, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$SurfaceGravity_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$SurfacePressure, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$SurfacePressure_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Carbon, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Carbon, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsCarbon_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Iron.1, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsIron_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Nickel, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Nickel, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsNickel_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Phosphorus, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsPhosphorus_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Sulphur, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsSulphur_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Arsenic, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsArsenic_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Chromium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Chromium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsChromium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Germanium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Germanium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsGermanium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Manganese, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Manganese, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsManganese_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Selenium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Selenium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsSelenium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Vanadium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsVanadium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Zinc, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Zinc, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsZinc_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Zirconium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsZirconium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Cadmium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsCadmium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Mercury, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Mercury, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsMercury_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Molybdenum, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsMolybdenum_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Niobium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Niobium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsNiobium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Tin, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Tin, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Tin, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsTin_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Tungsten, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsTungsten_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Antimony, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Antimony, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsAntimony_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Polonium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Polonium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsPolonium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Ruthenium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsRuthenium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Technetium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Technetium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsTechnetium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Tellurium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsTellurium_Zsc <- zsc", sep = "")))
  
  omega <- sd(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == Planet_Class))
  avg <- mean(subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == Planet_Class))
  zsc <- (subset(content_planets_final$Yttrium, content_planets_final$PlanetClass == Planet_Class) - avg)/omega
  eval(parse(text = paste(df_p, "$MineralsYttrium_Zsc <- zsc", sep = "")))
  
  return(eval(parse(text = paste(df_p, sep = ""))))
  }

#Check z-scores for attributes of...

Stars_K <- zs(Star_Type = "K", df = "Stars_K")
Stars_A <- zs(Star_Type = "A", df = "Stars_A")
Stars_B <- zs(Star_Type = "B", df = "Stars_B")
Stars_C <- zs(Star_Type = "C", df = "Stars_C")
Stars_F <- zs(Star_Type = "F", df = "Stars_F")
Stars_G <- zs(Star_Type = "G", df = "Stars_G")
Stars_BlackHole <- zs(Star_Type = "H", df = "Stars_BlackHole")
Stars_L <- zs(Star_Type = "L", df = "Stars_L")
Stars_M <- zs(Star_Type = "M", df = "Stars_M")
Stars_O <- zs(Star_Type = "O", df = "Stars_O")
Stars_CompactStars <- zs(Star_Type = "DA", df = "Stars_CompactStars")
Stars_Protostars <- zs(Star_Type = "T", df = "Stars_Protostars")
Stars_W <- zs(Star_Type = "W", df = "Stars_W")
Stars_Y <- zs(Star_Type = "Y", df = "Stars_Y")

Planets_HM <- zp(Planet_Class = "High Metal Content Body", df_p = "Planets_HM")
Planets_AW <- zp(Planet_Class = "Ammonia World", df_p = "Planets_AW")
Planets_E <- zp(Planet_Class = "Earthlike Body", df_p = "Planets_E")
Planets_I <- zp(Planet_Class = "Icy Body", df_p = "Planets_I")
Planets_MR <- zp(Planet_Class = "Metal Rich Body", df_p = "Planets_MR")
Planets_R <- zp(Planet_Class = "Rocky Body", df_p = "Planets_R")
Planets_RI <- zp(Planet_Class = "Rocky Ice Body", df_p = "Planets_RI")
Planets_S1GG <- zp(Planet_Class = "Sudarsky Class I Gas Giant", df_p = "Planets_S1GG")
Planets_S2GG <- zp(Planet_Class = "Sudarsky Class II Gas Giant", df_p = "Planets_S2GG")
Planets_S3GG <- zp(Planet_Class = "Sudarsky Class III Gas Giant", df_p = "Planets_S3GG")
Planets_S4GG <- zp(Planet_Class = "Sudarsky Class IV Gas Giant", df_p = "Planets_S4GG")
Planets_S5GG <- zp(Planet_Class = "Sudarsky Class V Gas Giant", df_p = "Planets_S5GG")
Planets_GGWL <- zp(Planet_Class = "Sudarsky Gas Giant With Life", df_p = "Planets_GGWL")
Planets_W <- zp(Planet_Class = "Water World", df_p = "Planets_W")
Planets_HRGG <- zp(Planet_Class = "Helium Rich Gas Giant", df_p = "Planets_HRGG")
Planets_WG <- zp(Planet_Class = "Water Giant", df_p = "Planets_WG")

setWinProgressBar(pb, 90, label = "Merging Data 90% Total Completion ")

content_zsc <- Reduce(function(...) merge(..., all=TRUE), list(
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
  Planets_GGWL,
  Planets_HRGG,
  Planets_WG
))

data_entries <- nrow(content)

for (i in 1:data_entries) {
  ifelse(content$StellarMass[i] > 0, content$Density[i] <- round(((content$StellarMass[i]*1989000000000000000000000000000)/((4/3)*(3.14159265358979323*content$Radius[i]^3))/10000000000000), digits = 8), content$Density[i] <- round(((content$EarthMasses[i]*5973600000000000000000000)/((4/3)*(3.14159265358979323*content$Radius[i]^3)))/100000000000, digits = 2))
}

data_entries <- nrow(content_zsc)
anomalies <- " "
  
for (i in 1:data_entries) {
  ifelse(content_zsc$Radius_Zsc[i] > 3,  content_zsc$Anomalies[i] <- "large radius", content_zsc$Anomalies[i] <- "")
  ifelse(content_zsc$Mass_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "massive", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Mass_Zsc[i] < -3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "less massive", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$SurfaceTemp_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "hot", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$SurfaceTemp_Zsc[i] < -3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "cold", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$RotationPeriod_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "rotating quickly", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$RotationPeriod_Zsc[i] < -3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "rotating slowly", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Eccentricity_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "oblong orbit", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Eccentricity_Zsc[i] < -3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "circular orbit", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Inclination_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "high positive inclination", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Inclination_Zsc[i] < -3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "high negative inclination", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Periapsis_Zsc[i] > 2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "high periapsis", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Periapsis_Zsc[i] < -2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "low periapsis", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$OrbitalPeriod_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "orbiting quickly", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$OrbitalPeriod_Zsc[i] < -2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "orbiting slowly", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$AxialTilt_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "high positive axial tilt", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$AxialTilt_Zsc[i] < -3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "high negative axial tilt", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$SurfaceGravity_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "high g", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$SurfaceGravity_Zsc[i] < -2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "low g", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$SurfacePressure_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "high pressure", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$SurfacePressure_Zsc[i] < -1,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "low pressure", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsCarbon_Zsc[i] > 1.7,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "carbon rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsIron_Zsc[i] > 1.7,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "iron rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsNickel_Zsc[i] > 1.7,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "nickel rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsPhosphorus_Zsc[i] > 1.7,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "phosphorus rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsSulphur_Zsc[i] > 1.7,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "sulphur rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsArsenic_Zsc[i] > 4,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "arsenic rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsChromium_Zsc[i] > 2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "chromium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsGermanium_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "germanium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsManganese_Zsc[i] > 2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "manganese rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsSelenium_Zsc[i] > 4,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "selenium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsVanadium_Zsc[i] > 2.6,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "vanadium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsZinc_Zsc[i] > 2.5,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "zinc rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsZirconium_Zsc[i] > 4,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "zirconium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsCadmium_Zsc[i] > 2.7,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "cadmium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsMercury_Zsc[i] > 3.4,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "mercury rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsMolybdenum_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "molybdenum rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsNiobium_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "niobium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsTin_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "tin rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsTungsten_Zsc[i] > 3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "tungsten rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsAntimony_Zsc[i] > 4,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "antimony rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsPolonium_Zsc[i] > 4.5,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "polonium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsRuthenium_Zsc[i] > 4,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "ruthenium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsTechnetium_Zsc[i] > 3.5,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "technetium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsTellurium_Zsc[i] > 4,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "tellurium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$MineralsYttrium_Zsc[i] > 3.6,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "yttrium rich", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Absolute_Magnitude_Zsc[i] > 2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "dim", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Absolute_Magnitude_Zsc[i] < -2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "bright", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Age_Zsc[i] > 2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "old", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
  ifelse(content_zsc$Age_Zsc[i] < -2,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "young", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
}

for (i in 1:data_entries) {
  ifelse(content_zsc$Radius_Zsc[i] < -3,  content_zsc$Anomalies[i] <- paste(content_zsc$Anomalies[i], "small radius", sep = ", "), paste(content_zsc$Anomalies[i], "", sep = ""))
}

content_zsc_significant <- subset(content_zsc,
                                          content_zsc$Radius_Zsc > 3 |
                                          content_zsc$Mass_Zsc > 3 |
                                          content_zsc$SurfaceTemp_Zsc > 3 |
                                          content_zsc$RotationPeriod_Zsc > 3 |
                                          content_zsc$Eccentricity_Zsc > 3 |
                                          content_zsc$Inclination_Zsc > 3 |
                                          content_zsc$AxialTilt_Zsc > 3 |
                                          content_zsc$SurfaceGravity_Zsc > 3 |
                                          content_zsc$SurfacePressure_Zsc > 3 |
                                          content_zsc$MineralsCarbon_Zsc > 1.7 |
                                          content_zsc$MineralsAntimony_Zsc > 4 |
                                          content_zsc$MineralsArsenic_Zsc > 4 |
                                          content_zsc$MineralsCadmium_Zsc > 2.7 |
                                          content_zsc$MineralsIron_Zsc > 1.7 |
                                          content_zsc$MineralsChromium_Zsc > 2 |
                                          content_zsc$MineralsGermanium_Zsc > 3 |
                                          content_zsc$MineralsManganese_Zsc > 2 |
                                          content_zsc$MineralsMercury_Zsc > 3.4 |
                                          content_zsc$MineralsMolybdenum_Zsc > 3 |
                                          content_zsc$MineralsNickel_Zsc > 1.7 |
                                          content_zsc$MineralsNiobium_Zsc > 3 |
                                          content_zsc$MineralsPhosphorus_Zsc > 1.7 |
                                          content_zsc$MineralsPolonium_Zsc > 4.5 |
                                          content_zsc$MineralsRuthenium_Zsc > 4 |
                                          content_zsc$MineralsSelenium_Zsc > 4 |
                                          content_zsc$MineralsSulphur_Zsc > 1.7 |
                                          content_zsc$MineralsTechnetium_Zsc > 3.5 |
                                          content_zsc$MineralsTellurium_Zsc > 4 |
                                          content_zsc$MineralsTin_Zsc > 3 |
                                          content_zsc$MineralsTungsten_Zsc > 3 |
                                          content_zsc$MineralsVanadium_Zsc > 2.6 |
                                          content_zsc$MineralsYttrium_Zsc > 3.6 |
                                          content_zsc$MineralsZinc_Zsc > 2.5 |
                                          content_zsc$MineralsZirconium_Zsc > 4 |
                                          content_zsc$Absolute_Magnitude_Zsc > 2 |
                                          content_zsc$Age_Zsc > 2 |
                                          content_zsc$Radius_Zsc < -3 |
                                          content_zsc$Mass_Zsc < -3 |
                                          content_zsc$SurfaceTemp_Zsc < -3 |
                                          content_zsc$RotationPeriod_Zsc < -3 |
                                          content_zsc$Eccentricity_Zsc < -3 |
                                          content_zsc$Inclination_Zsc < -3 |
                                          content_zsc$AxialTilt_Zsc < -3 |
                                          content_zsc$SurfaceGravity_Zsc < -3 |
                                          content_zsc$SurfacePressure_Zsc < -3 |
                                          content_zsc$Absolute_Magnitude_Zsc < -2 |
                                          content_zsc$Age_Zsc < -2
                                  )

data_entries <- nrow(content_zsc)

content_zsc <- content_zsc[,c("Anomalies",setdiff(names(content_zsc),"Anomalies"))]
content_zsc <- content_zsc[,c("BodyName",setdiff(names(content_zsc),"BodyName"))]
content_zsc <- content_zsc[,c("X",setdiff(names(content_zsc),"X"))]
content_zsc_significant <- content_zsc_significant[,c("Anomalies",setdiff(names(content_zsc_significant),"Anomalies"))]
content_zsc_significant <- content_zsc_significant[,c("BodyName",setdiff(names(content_zsc_significant),"BodyName"))]
content_zsc_significant <- content_zsc_significant[,c("X",setdiff(names(content_zsc_significant),"X"))]

content_zsc_significant_recent <- subset(content_zsc_significant, content_zsc_significant$X < data_entries & content_zsc_significant$X > (data_entries-25))

###############################################################################

write.csv(content_zsc, file = "AME Catalogue (Z-Scores).csv")

setWinProgressBar(pb, 100, label = "Cleaning Up 100% Total Completion ")

system('cscript say.vbs "Completed program, stand by for anomalous reedings report"')

close(pb)

#Opens Both CSVs in the RStudio Viewer
View(content_zsc_significant)
View(content)
View(content_zsc)
View(content_zsc_significant_recent)

Sys.sleep(7)

text <- ""
data_entries <- nrow(content_zsc_significant_recent)
for (i in 1:data_entries) {
  text <- paste(text, "body name", content_zsc_significant_recent$BodyName[i], "has anomalies", content_zsc_significant_recent$Anomalies[i], ".", sep = " ")
}
text_final <- paste('cscript say.vbs ', '"', text, '"', sep = "")
system(text_final)
