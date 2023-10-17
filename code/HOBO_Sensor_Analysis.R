#############################################
# Processing of CoBRA HOBO Sensor Data
# Matthew Berens
# Updated June 2023
#############################################

#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")


################################################################################
# Step 1. Import the Data ------------------------------------------------------
#Load Water Level Data
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Water Level/processed")
WL_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) %>%
  mutate(DateTime = lubridate::ymd_hms(DateTime))

setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO pH/processed")
pH_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) %>%
  mutate(DateTime = lubridate::ymd_hms(DateTime))

setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/HOBO Conductivity/processed")
Conductivity_merged <- bind_rows(lapply(list.files(pattern="*.csv$"), read.csv)) %>%
  mutate(DateTime = lubridate::ymd_hms(DateTime))



# Step 5. Visually check data --------------------------------------------------
ggplot() +
  geom_line(data = subset(Conductivity_merged, transect == "Old" & plot == "1"), aes(x = DateTime, y = adjusted_SpC))+
  geom_line(data = subset(WL_merged, transect == "Old" & plot == "1"), aes(x = DateTime, y = water_level*500+1000), color = "blue")+
  facet_wrap(~transect, nrow = 2) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_x_datetime(date_breaks = "2 weeks" , date_labels = "%Y/%m/%d")+
  theme_mb1() +
  labs(y = "Specific Conductance (uS/cm)", x = NULL, title = "Old Transect - Plot 1")

ggplot() +
  geom_line(data = subset(Conductivity_merged, transect == "Old" & plot == "5"), aes(x = DateTime, y = adjusted_SpC))+
  geom_line(data = subset(WL_merged, transect == "Old" & plot == "1"), aes(x = DateTime, y = water_level*500+1000), color = "blue")+
  facet_wrap(~transect, nrow = 2) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_x_datetime(date_breaks = "2 weeks" , date_labels = "%Y/%m/%d")+
  theme_mb1() +
  labs(y = "Specific Conductance (uS/cm)", x = NULL, title = "Old Transect - Plot 5")

ggplot() +
  geom_line(data = subset(Conductivity_merged, transect == "Young" & plot == "1"), aes(x = DateTime, y = adjusted_SpC))+
  geom_line(data = subset(WL_merged, transect == "Young" & plot == "1"), aes(x = DateTime, y = water_level*500+1000), color = "blue")+
  facet_wrap(~transect, nrow = 2) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_x_datetime(date_breaks = "2 weeks" , date_labels = "%Y/%m/%d")+
  theme_mb1() +
  labs(y = "Specific Conductance (uS/cm)", x = NULL, title = "Young Transect - Plot 1")

ggplot() +
  geom_line(data = subset(Conductivity_merged, transect == "Young" & plot == "3"), aes(x = DateTime, y = adjusted_SpC))+
  geom_line(data = subset(WL_merged, transect == "Young" & plot == "3"), aes(x = DateTime, y = water_level*500+1000), color = "blue")+
  facet_wrap(~transect, nrow = 2) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_x_datetime(date_breaks = "2 weeks" , date_labels = "%Y/%m/%d")+
  theme_mb1() +
  labs(y = "Specific Conductance (uS/cm)", x = NULL, title = "Young Transect - Plot 3")

ggplot() +
  geom_line(data = subset(Conductivity_merged, transect == "Young" & plot == "4"), aes(x = DateTime, y = adjusted_SpC))+
  geom_line(data = subset(WL_merged, transect == "Young" & plot == "3"), aes(x = DateTime, y = water_level*2000+3000), color = "blue")+
  facet_wrap(~transect, nrow = 2) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_x_datetime(date_breaks = "2 weeks" , date_labels = "%Y/%m/%d")+
  theme_mb1() +
  labs(y = "Specific Conductance (uS/cm)", x = NULL, title = "Young Transect - Plot 4")



ggsave(plot = last_plot(), "f/Water Level ALL.png", width = 9, unit = "in")

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
