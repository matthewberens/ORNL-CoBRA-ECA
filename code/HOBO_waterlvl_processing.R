#Analysis of HOBO Data
#pH and Temperature 2023
library(lubridate)
library(ggplot2)
library(plyr)
library(magrittr)
library(dplyr)

#Data input of 2023 HOBO pH/Temp measurements
setwd("~/Documents/CoBRA-ECA/data/HOBO_waterlvl/20230508_waterlvl")

# Get the file names but exclude the sensor list
file_names <- dir()[!dir() %in% c("20230508_waterlvl_sensorlist.csv", "output")]

#Import the list of sensors
sensorList<-read.csv("20230508_waterlvl_sensorlist.csv")

#Bind all sensor data into one data frame
waterlvl <- do.call(rbind, lapply(file_names,read.csv))
head(waterlvl)

#Set names of columns
names(waterlvl)<-c("sampleNo","DateTime","P_kPa","temp_C", "sensorID")

#Double check data frams structure
str(waterlvl)

#Double check list of sensors
unique(waterlvl$sensor)


#Make DateTime as POSIXct object and extract year
#Merge in sensor details
waterlvl <- waterlvl %>%
  mutate(Date_formatted = mdy_hm(DateTime),
         Year = year(Date_formatted),
         DOY = yday(Date_formatted),
         Hour = hour(Date_formatted),
         Minute = minute(Date_formatted)) %>%
  merge(sensorList, by="sensorID")

#Double check column names are correct
head(waterlvl)

#Visually check that sensors are working
ggplot(waterlvl,aes(x=Date_formatted,y=P_kPa,color=tidal)) +
  geom_line()+
  facet_wrap(~transect) +
  theme_bw()

#Create a metadata table
metadata<-ddply(waterlvl,c("sensorID","region","transect","plot", "tidal"),summarise,
                start_dateTime=min(Date_formatted),
                end_dateTime = max(Date_formatted),
                total_reads = n(),
                waterlvl_errors = sum(is.na(waterlvl)),
                temp_errors = sum(is.na(temp_C)))

#Output metadata to the directory
write.csv(metadata,"output/metadata_waterlvl_20230508.csv",row.names = F)

#Create a summary table
summaries<-ddply(waterlvl,c("sensorID","region","transect","plot", "tidal"),summarise,
                min_waterlvl = min(P_kPa),
                mean_waterlvl = mean(P_kPa),
                max_waterlvl = max(P_kPa),
                min_temp = min(temp_C),
                mean_temp = mean(temp_C),
                max_temp = max(temp_C))

#Output summaries to the directory
write.csv(summaries,"output/summaries_waterlvl_20230508.csv",row.names = F)

#Output final data to the directory
write.csv(waterlvl,"output/waterlvl_data_20230508.csv",row.names = F)
