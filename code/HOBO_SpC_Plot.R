#############################################
# Plotting of CoBRA HOBO Sensor Data
# Matthew Berens
# Updated Aug 2023
#############################################

#Load libraries and packages
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA")
source("code/0-packages.R")


# Step 1. Load Data ---------------------------------------------------------------------

MaySpC <- read.csv("sensor data/processed/processed_May2023_SpC.csv")
JulySpC <- read.csv("sensor data/processed/processed_July2023_SpC.csv")


allSpC <- rbind(MaySpC, JulySpC) %>%
  mutate(Date_formatted = mdy_hm(DateTime),
         tidal = factor(tidal, levels = c("supratidal", "intertidal", "subtidal"))) #Merge the data sets together

# Step 2. Quickly check data ---------------------------------------------------------
allSpC %>%
  filter(result_value > 1000) %>%
  ggplot(aes(x=Date_formatted,y=result_value, color=tidal)) +
  #geom_vline(xintercept = as.numeric(ymd_hms("2023-05-08 12:00:00")), linetype="dashed", size=0.5)+
  geom_line()+
  facet_wrap(~transect, nrow = 2, scales = "free_y") +
  scale_color_manual(values = c("#C85E6D",  "#F4CA4E", "#3F0898")) +
  theme_mb1() +
  scale_x_datetime(breaks = "month", date_labels = "%b %Y", expand = c(0,0)) +
  labs(x = NULL, y = "Conductivity (uS/cm)")
