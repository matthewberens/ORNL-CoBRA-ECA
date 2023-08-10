#############################################
# Processing of CoBRA HOBO Sensor Data
# Matthew Berens
# Updated June 2023
#############################################

#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")

#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/July2023_SWAP")



# Step 1. Load Data ---------------------------------------------------------------------

DL42385_formatted <- read.csv("20230711_DL42385.csv") %>%
  pivot_longer(-c("DateTime":"PTemp_C"), values_to = "result_value", names_to = "SWAP_id") %>%
  mutate(type = gsub("^(.*?)_.*", "\\1", SWAP_id),
         depth = sub('.*\\_', '', SWAP_id),
         sensorID = stri_extract(SWAP_id, regex = '(?<=_).*(?=_)')) %>%
  select(-"SWAP_id")%>%
  spread(value = "result_value", key = "type", fill = NA) %>%
  mutate(result_value = ifelse(Std > 5, NA, Avg)) %>%
  merge(sensorList, by = "sensorID")

DL42389_formatted <- read.csv("20230711_DL42389.csv") %>%
  pivot_longer(-c("DateTime":"PTemp_C"), values_to = "result_value", names_to = "SWAP_id") %>%
  mutate(type = gsub("^(.*?)_.*", "\\1", SWAP_id),
         depth = sub('.*\\_', '', SWAP_id),
         sensorID = stri_extract(SWAP_id, regex = '(?<=_).*(?=_)')) %>%
  select(-"SWAP_id")%>%
  spread(value = "result_value", key = "type", fill = NA) %>%
  mutate(result_value = ifelse(Std > 5, NA, Avg)) %>%
  merge(sensorList, by = "sensorID")

DL42391_formatted <- read.csv("20230711_DL42391.csv") %>%
  pivot_longer(-c("DateTime":"PTemp_C"), values_to = "result_value", names_to = "SWAP_id") %>%
  mutate(type = gsub("^(.*?)_.*", "\\1", SWAP_id),
         depth = sub('.*\\_', '', SWAP_id),
         sensorID = stri_extract(SWAP_id, regex = '(?<=_).*(?=_)')) %>%
  select(-"SWAP_id")%>%
  spread(value = "result_value", key = "type", fill = NA) %>%
  mutate(result_value = ifelse(Std > 5, NA, Avg)) %>%
  merge(sensorList, by = "sensorID")

# Step 3. Format Date and Time  ---------------------------------------------------------
sensor_data <- bind_rows(DL42385_formatted, DL42389_formatted, DL42391_formatted)

# Step 3. Format Date and Time  ---------------------------------------------------------
sensor_data <- sensor_data %>%
  mutate(Date_formatted = mdy_hm(DateTime),
         Year = year(Date_formatted),
         DOY = yday(Date_formatted))

# Step 4. Visually check data ---------------------------------------------------------
sensor_data %>%
  subset(transect == "Young") %>%
  subset(depth != 0) %>%
  #mutate(sensorID = factor(sensorID, levels = c("220915_11", "220915_19", "220915_06"))) %>%
  #mutate(sensorID = factor(sensorID, levels = c("220915_11", "220915_19", "220915_06"))) %>%
  ggplot() +
  stat_summary(aes(x=Date_formatted,y=result_value + 197 , color=depth), geom = "line") +
  #geom_line(aes(x=Date_formatted,y=result_value + 197 , color=depth)) +
  #geom_vline(xintercept = as.numeric(ymd_hms("2023-06-06 12:00:00")), linetype="dashed", size=0.5)+
  scale_color_manual(values = colors_depth)+
  #facet_wrap(~sensorID, nrow = 4,
   #          labeller = as_labeller(c("220915_06" = "OT3 - Intertidal",
    #                                  "220915_19" = "OT3 - Intertidal",
     #                                 "220915_11" = "OT2 - Supratidal"))) +
  facet_wrap(~sensorID, nrow = 4,
             labeller = as_labeller(c("220915_04" = "YT1 - Supratidal",
                                      "220915_07" = "YT2 - Intertidal-High",
                                      "220915_08" = "YT2 - Intertidal-Low",
                                      "220915_24" = "YT4 - Subtidal",
                                      "220915_15" = "YT3 - Intertidal",
                                      "220915_12" = "YT3 - Intertidal"))) +
  theme_mb1() +
  scale_x_datetime(breaks = "month", date_labels = "%b %Y", expand = c(0,0)) +
  labs(x = NULL, y = "Redox Potential (mV vs SHE)", color = "Depth (cm)")

ggsave(plot = last_plot(), "output/Redox_Young_all.png", width = 12, height = 9, units = "in")

# Step 2. Set names of data columns  ----------------------------------------------------

#Run this line for conductivity
names(rawdata)<-c("sampleNo","DateTime","result_value", "temp","sensorID")

#Run this lines for pH
names(rawdata)<-c("sampleNo","DateTime", "temp", "mV", "result_value","sensorID")

#Run this lines for Water Leve
names(rawdata)<-c("sampleNo","DateTime", "result_value", "temp", "sensorID")


rawdata <- rawdata %>%  relocate(temp, .before = result_value) #Move the temp data before probe measurement
head(rawdata) #Double check data frame structure










head(sensor_data) #Double check column names are correct



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
