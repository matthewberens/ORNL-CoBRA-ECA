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
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/21446317_Old_5")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","temp", "raw_mV", "pH")
pH_Old_5 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Old",
         plot = "5",
         tidal = "subtidal")

write.csv(pH_Old_5,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/processed/SUMMARY pH_Old_5.csv",row.names = F)
################################################################################

# Step 1. Old Transect - Plot 1 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/21446319_Old_1")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","temp", "raw_mV", "pH")
pH_Old_1 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Old",
         plot = "1",
         tidal = "supratidal")

write.csv(pH_Old_1,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/processed/SUMMARY pH_Old_1.csv",row.names = F)
################################################################################

#Step 1. Old Transect - Plot 4 ---------------------------------------------------------------------
#Set directory to sensor of interest
  setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/21414145_Old_4")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","temp", "raw_mV", "pH")
pH_Old_4 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Old",
         plot = "4",
         tidal = "subtidal")

write.csv(pH_Old_4,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/processed/SUMMARY pH_Old_4.csv",row.names = F)
################################################################################


#Step 1. Young Transect - Plot 1 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/21446321_Young_1")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","temp", "raw_mV", "pH")
pH_Young_1 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Young",
         plot = "1",
         tidal = "supratidal")

write.csv(pH_Young_1,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/processed/SUMMARY pH_Young_1.csv",row.names = F)
################################################################################

#Step 1. Young Transect - Plot 3 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/21446324_Young_3")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","temp", "raw_mV", "pH")
pH_Young_3 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Young",
         plot = "3",
         tidal = "intertidal")

write.csv(pH_Young_3,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/processed/SUMMARY pH_Young_3.csv",row.names = F)
################################################################################


#Step 1. Young Transect - Plot 4 ---------------------------------------------------------------------
#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/21446320_Young_4")

#reading in csv files can also be done using the base R function read.csv(), without needing to load package "data.table":
df_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) 
names(df_merged) <- c("sampleNo","DateTime","temp", "raw_mV", "pH")
pH_Young_4 <- df_merged %>%
  mutate(DateTime = mdy_hm(DateTime),
         transect = "Young",
         plot = "4",
         tidal = "subtidal")

write.csv(pH_Young_4,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed/SUMMARY pH_Young_4.csv",row.names = F)
################################################################################


combined_pH<- bind_rows(pH_Old_1, pH_Old_4, pH_Old_5, pH_Young_1, pH_Young_3, pH_Young_4)

# Step 5. Visually check data ---------------------------------------------------------
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/processed")
combined_pH %>%
subset(DateTime > mdy("03/19/2023")) %>%
ggplot(aes(x=DateTime,y=pH)) +
  geom_line(aes(color = plot))+
  facet_wrap(~transect, nrow = 2) +
  scale_color_viridis(begin = 0, end = 0.9, direction = -1,discrete = TRUE, option = "plasma") +
  scale_x_datetime(date_breaks = "2 weeks" , date_labels = "%Y/%m")+
  theme_mb1() +
  labs(y = "pH", x = NULL, color = "Plot")

ggsave(plot = last_plot(), "f/pH ALL.png", width = 9, unit = "in")

# Step 6. Create raw metadata table ---------------------------------------------------------
metadata<-ddply(na.omit(sensor_data),c("sensorID","transect","plot", "tidal"), dplyr::summarise,
                start_dateTime=min(Date_formatted),
                end_dateTime = max(Date_formatted),
                total_reads = n(),
                result_errors = sum(is.na(result_value)),
                temp_errors = sum(is.na(temp)),
                min_result = min(result_value),
                mean_result = mean(result_value),
                max_result = max(result_value),
                min_temp = min(temp),
                mean_temp = mean(temp),
                max_temp = max(temp))



#Output metadata to the directory
write.csv(sensor_data,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/processed/processed_July2023_pH.csv",row.names = F)




write.csv(sensor_data,"~/Documents/CoBRA-ECA/data/sensor data/processed/processed_July2023_SpC.csv",row.names = F)


may <- read.csv("~/Documents/CoBRA-ECA/data/sensor data/output/processed_May2023_SpC.csv")
july <- read.csv("~/Documents/CoBRA-ECA/data/sensor data/output/processed_July2023_SpC.csv")
bind <- rbind(july, may) %>%
  mutate(Date_formatted = mdy_hm(DateTime))

write.csv(sensor_data,"~/Documents/CoBRA-ECA/data/sensor data/output/SpC_WLD_2023.csv",row.names = F)
