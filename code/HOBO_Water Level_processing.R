#############################################
# Processing of CoBRA HOBO Sensor Data
# Matthew Berens
# Updated June 2023
#############################################

#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")


################################################################################
# Step 1. Old Transect - Plot 1 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Water Level/21411067_Old_1")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) %>%
  dplyr::select(-Pressure.Barom...kPa) %>%
  na.omit()

names(df_merged) <- c("sampleNo","DateTime","pressure_kPa", "temp", "water_level")
WL_Old_1 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Old",
         plot = "1",
         tidal = "supratidal")



# Step 1. Old Transect - Plot 3 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Water Level/21411068_Old_3")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) %>%
  dplyr::select(-Pressure.Barom...kPa) %>%
  na.omit()

names(df_merged) <- c("sampleNo","DateTime","pressure_kPa", "temp", "water_level")
WL_Old_3 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Old",
         plot = "3",
         tidal = "intertidal")


################################################################################

#Step 1. Young Transect - Plot 1 ---------------------------------------------------------------------
#Set directory to sensor of interest
  setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Water Level/21411062_Young_1")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) %>%
  dplyr::select(-Pressure.Barom...kPa) %>%
  na.omit()

names(df_merged) <- c("sampleNo","DateTime","pressure_kPa", "temp", "water_level")
WL_Young_1 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Young",
         plot = "1",
         tidal = "supratidal")


#Step 1. Young Transect - Plot 3 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Water Level/21411059_Young_3")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) %>%
  dplyr::select(-Pressure.Barom...kPa) %>%
  na.omit()

names(df_merged) <- c("sampleNo","DateTime","pressure_kPa", "temp", "water_level")
WL_Young_3 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Young",
         plot = "3",
         tidal = "intertidal")


################################################################################

combined_WL<- bind_rows(WL_Old_1, WL_Old_3, WL_Young_1, WL_Young_3)

setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Water Level")
write.csv(combined_WL, "processed/combined_depth_2023", row.names = FALSE)

