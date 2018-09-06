###############################################################################

# PLEASE FOR GOD'S SAKE READ THE README

# VARIABLES YOU SHOULD EDIT

# The prefix is what goes in front of your object names in the catalogue
# For example, if you put 'ROFL' as the prefix, you'll get names like
# ROFL-13HM and ROFL-S134FIV
# Type your prefix between the quotes 

prefix <- ""

# The directory is where the AME Catalogue will look for your ED Discovery
# spreadsheets, and where it'll export its own spreadsheets to. If you don't put
# your ED Discovery Spreadsheets in this directory, the program will not work.
# Type your directory between the quotes. In Windows, you can right click the top bar
# of the file explorer window where it shows the path, then click "copy address as text,"
# then you can paste the path between the quotes below.

directory <- ""

# Below is where you put all your custom names for celestial objects.
# I would highly recommend running the entire main program first (CTRL+SHIFT+S)
# before you fill out this section so you can look up the new catalogue name
# after they've been generated. After "names_cat <- c(" where it says "PUT YOUR NAMES HERE", 
# put the name (from the CatRef column of the "AME Catalogue (Final).csv") of the object
# you want to give a custom name to. Each entry should go on a separate line between quotes.
# There should be a comma at the end of every line outside the quotes, except for after the last line.
# Similarly, put your custom name entries on the lines between the parenthesis after
# "names_custom <- c(". In each respective list, the name from the catalogue and the custom name must be
# on the same line. For example, if the catalogue name is on the third line after "names_cat <- c(", the custom
# name should be on the third line after "names_custom <- c(".

names_cat <- NA
names_cat <- c(
  PUT YOUR NAMES HERE
  )
names_cat <- as.data.frame(names_cat)

names_custom <- NA
names_custom <- c(
  PUT YOUR CUSTOM NAMES HERE
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
