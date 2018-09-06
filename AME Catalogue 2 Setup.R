###############################################################################

# PLEASE FOR GOD'S SAKE READ THE README

# VARIABLES YOU SHOULD EDIT

# The prefix is what goes in front of your object names in the catalogue
# For example, if you put 'ROFL' as the prefix, you'll get names like
# ROFL-13HM and ROFL-S134FIV
# Type your prefix between the quotes 

prefix <- "AME"

# The directory is where the AME Catalogue will look for your ED Discovery
# spreadsheets, and where it'll export its own spreadsheets to. If you don't put
# your ED Discovery Spreadsheets in this directory, the program will not work.
# Type your directory between the quotes. In Windows, you can right click the top bar
# of the file explorer window where it shows the path, then click "copy address as text,"
# then you can paste the path between the quotes below.

directory <- "C:/Users/Ame No Kanashi Okami/Google Drive/Windows Mac Share/AME Catalogue"

# Below is where you put all your custom names for celestial objects.
# I would highly recommend running the entire main program first (CTRL+SHIFT+S)
# before you fill out this section so you can look up the new catalogue name
# after they've been generated. After "names_cat <- c(" where it says "PUT YOUR NAMES HERE", 
# put the name (from the CatRef column of the "AME Catalogue (Final).csv") of the object
# you want to give a custom name to. Each entry should go on a separate line between the quotes.
# There should be a comma at the end of every line you put it, except for the last line.
# Similarly, put your custom name entries on the lines between the parenthesis after
# "names_custom <- c(".

names_cat <- NA
names_cat <- c(
  "AME-2888HM",
  "AME-2887HM",
  "AME-2890S1GG",
  "AME-517HM",
  "AME-2928W",
  "AME-3038HM",
  "AME-S2417AVI",
  "AME-2418MR",
  "AME-2419S3GG",
  "AME-2422R",
  "AME-2421R",
  "AME-2420R",
  "AME-2423R",
  "AME-2424R",
  "AME-2425HM",
  "AME-2426S3GG",
  "AME-2428R",
  "AME-2429R",
  "AME-2430R",
  "AME-2427R",
  "AME-3279I",
  "AME-3288HM",
  "AME-3387HM",
  "AME-S3615FVI",
  "AME-3616HM",
  "AME-3617HM",
  "AME-3618E",
  "AME-3619HM",
  "AME-3620E",
  "AME-3622HM",
  "AME-3623HM",
  "AME-3624HM",
  "AME-3676MR",
  "AME-3678S3GG",
  "AME-S3768FVb",
  "AME-3772E",
  "AME-3771E",
  "AME-3816E",
  "AME-3817R",
  "AME-3818R",
  "AME-3819R",
  "AME-3877HM",
  "AME-3876HM",
  "AME-4223E",
  "AME-S4536MVa",
  "AME-S4535TV"
  )
names_cat <- as.data.frame(names_cat)

names_custom <- NA
names_custom <- c(
  "Twin Sisters (1)",
  "Twin Sisters (2)",
  "White-Tail",
  "Goliath",
  "Miller's World",
  "Yttria",
  "Gli Nonni",
  "Gli Nonni 1",
  "Gli Nonni 3",
  "Gli Nonni 3 a",
  "Gli Nonni 3 b",
  "Gli Nonni 3 c",
  "Gli Nonni 3 d",
  "Gli Nonni 3 e",
  "Gli Nonni 2",
  "Gli Nonni 4",
  "Gli Nonni 4 a",
  "Gli Nonni 4 b",
  "Gli Nonni 4 c",
  "Gli Nonni 4 d",
  "Stracciatella",
  "Wagon Wheel",
  "Blackheart",
  "Wulf's Star",
  "Wulf's Star 2",
  "Wulf's Star 3",
  "Wulf's Star 4",
  "Wulf's Star 5",
  "Wulf's Star 6",
  "Jake's World",
  "Sabrina's World",
  "Trevor's World",
  "Kilauea",
  "Purple Haze",
  "Terral",
  "Terra Primus",
  "Terra Secondus",
  "Ring of Aquila",
  "Aquila 1",
  "Aquila 2",
  "Aquila 3",
  "Cabrakan's Rings (1)",
  "Cabrakan's Rings (2)",
  "Infinity Ring",
  "Alpha Eos Aowsy",
  "Beta Eos Aowsy"
)
names_custom <- as.data.frame(names_custom)

###############################################################################

# DON'T EDIT ANY OF THIS STUFF

vars <- as.data.frame(NA)
vars$prefix <- prefix
vars$directory <- directory
write.csv(vars, file = "vars.rvars")
write.csv(names_cat, file = "names_cat.rvars")
write.csv(names_custom, file = "names_custom.rvars")

###############################################################################