#############################################
# Processing of CoBRA HOBO Sensor Data
# Matthew Berens
# Updated June 2023
#############################################

#Load libraries and packages
source("~/Documents/CoBRA-ECA/code/0-packages.R")

#Set directory to sensor of interest
setwd("~/Documents/CoBRA-ECA/data/sensor data/July2023_SpC")



# Step 1. Load Data ---------------------------------------------------------------------

rawdata <- do.call(rbind, lapply(dir(),read.csv)) #Load individual data sets for each sensor
head(rawdata)



# Step 2. Set names of data columns  ----------------------------------------------------

#Run this line for conductivity
names(rawdata)<-c("sampleNo","DateTime","result_value", "temp","sensorID")
rawdata <- rawdata %>%  relocate(temp, .before = result_value) #Move the temp data before probe measurement


#Run these lines for pH
names(rawdata)<-c("sampleNo","DateTime", "temp", "mV", "result_value","sensorID")


head(rawdata) #Double check data frame structure



# Step 3. Set names of data columns  ----------------------------------------------------

sensor_data <- merge(rawdata, sensorList, by="sensorID")
head(sensor_data ) #Double check data frame structure



# Step 3. Format Date and Time  ---------------------------------------------------------
sensor_data <- sensor_data %>%
  mutate(Date_formatted = mdy_hm(DateTime),
         Year = year(Date_formatted),
         DOY = yday(Date_formatted))


head(sensor_data) #Double check column names are correct

# Step 3. Visually check data ---------------------------------------------------------
ggplot(sensor_data,aes(x=Date_formatted,y=result_value, color=tidal)) +
  geom_line()+
  facet_wrap(~transect) +
  theme_mb1()

# Step 4. Create raw metadata table ---------------------------------------------------------
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
write.csv(metadata,"~/Documents/CoBRA-ECA/data/sensor data/processed/metadata_July2023_SpC.csv",row.names = F)

write.csv(sensor_data,"~/Documents/CoBRA-ECA/data/sensor data/processed/processed_May2023_pH.csv",row.names = F)


may <- read.csv("~/Documents/CoBRA-ECA/data/sensor data/output/processed_May2023_SpC.csv")
july <- read.csv("~/Documents/CoBRA-ECA/data/sensor data/output/processed_July2023_SpC.csv")
bind <- rbind(july, may) %>%
  mutate(Date_formatted = mdy_hm(DateTime))

write.csv(sensor_data,"~/Documents/CoBRA-ECA/data/sensor data/output/SpC_WLD_2023.csv",row.names = F)
