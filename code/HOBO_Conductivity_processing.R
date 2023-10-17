#############################################
# Processing of CoBRA HOBO Sensor Data
# Matthew Berens
# Updated June 2023
#############################################

#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")


################################################################################
# Step 1. Old Transect - Plot 5 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/21445979_Old_5")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","raw_EC", "temp","adjusted_SpC")
SpC_Old_5 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Old",
         plot = "5",
         tidal = "subtidal")

write.csv(SpC_Old_5,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed/SUMMARY SpC_Old_5.csv",row.names = F)
################################################################################

# Step 1. Old Transect - Plot 1 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/21445985_Old_1")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","raw_EC", "temp","adjusted_SpC")
SpC_Old_1 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Old",
         plot = "1",
         tidal = "supratidal")

write.csv(SpC_Old_1,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed/SUMMARY SpC_Old_1.csv",row.names = F)
################################################################################

#Step 1. Old Transect - Plot 4 ---------------------------------------------------------------------
#Set directory to sensor of interest
  setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/21445986_Old_4")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","raw_EC", "temp","adjusted_SpC")
SpC_Old_4 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Old",
         plot = "4",
         tidal = "subtidal")

write.csv(SpC_Old_4,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed/SUMMARY SpC_Old_4.csv",row.names = F)
################################################################################


#Step 1. Young Transect - Plot 1 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/21445984_Young_1")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","raw_EC", "temp","adjusted_SpC")
SpC_Young_1 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Young",
         plot = "1",
         tidal = "supratidal")

write.csv(SpC_Young_1,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed/SUMMARY SpC_Young_1.csv",row.names = F)
################################################################################

#Step 1. Young Transect - Plot 3 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/21445995_Young_3")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","raw_EC", "temp","adjusted_SpC")
SpC_Young_3 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Young",
         plot = "3",
         tidal = "intertidal")

write.csv(SpC_Young_3,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed/SUMMARY SpC_Young_3.csv",row.names = F)
################################################################################


#Step 1. Young Transect - Plot 4 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/21445994_Young_4")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","raw_EC", "temp","adjusted_SpC")
SpC_Young_4 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Young",
         plot = "4",
         tidal = "subtidal")

write.csv(SpC_Young_4,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed/SUMMARY SpC_Young_4.csv",row.names = F)
################################################################################


combined_SpC<- bind_rows(SpC_Old_1, SpC_Old_4, SpC_Old_5, SpC_Young_1, SpC_Young_3, SpC_Young_4)

#Output metadata to the directory
write.csv(combined_SpC,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed/combined_conductivity_2023.csv",row.names = F)

# Step 5. Visually check data ---------------------------------------------------------
combined_SpC %>%
subset(adjusted_SpC > 100) %>%
ggplot(aes(x=DateTime,y=adjusted_SpC)) +
  geom_line(aes(color = plot))+
  facet_wrap(~transect, nrow = 2, scales = "free_y") +
  theme_mb1()






