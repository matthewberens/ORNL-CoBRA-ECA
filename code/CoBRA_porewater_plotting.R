#############################################
# CoBRA Sampling Data Processing
# Matthew Berens
# Updated June 2023
#############################################

#Load libraries and set directory
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA")

#load packages
source("code/0-packages.R")

# Step 1. Load Data ---------------------------------------------------------------------

sampling_data_Mar = read.csv("porewater data/processed/CoBRA POREWATER_Mar2023.csv") 
sampling_data_July = read.csv("porewater data/processed/CoBRA POREWATER_July2023.csv") 



######################################
#Relative Water Level 
relative_wl_July2023 <- read.csv("porewater data/raw/CoBRA_water_level_July2023.csv") 
relative_wl_Mar2023 <- read.csv("porewater data/raw/CoBRA_water_level_Mar2023.csv") 

wl_all <- rbind(relative_wl_July2023, relative_wl_Mar2023) %>%
  mutate(date = lubridate::mdy(date),
         month = lubridate::month(date, label = TRUE))

wl_all %>%
  ggplot(aes(x = distance, y = -depth)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "Blue") +
  #geom_point()+
  stat_summary(shape = 21, fill = "brown", size = 1) +
  theme_mb1() +
  facet_wrap(transect~month, 
             nrow=2, 
             scales = "free_x") +
  labs(y = "Relative water level (cm)", x = "Distance (m)") 
  theme(aspect.ratio = 0.5)





### OLD TRANSECT PLOTS ######
rbind(sampling_data_July) %>%
  #subset(transect == "old") 
  subset(transect != "blank") %>%
  #subset(parameter %in% c( "Ca", "SpC", "ORP", "Cl", "SO4")) %>%
  #subset(parameter %in% c("Fe_OES", "Fe_II", "DOC", "DIC")) %>%
  subset(parameter == "temp") %>%
  ggplot(aes(y=depth, x=result_value)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "Blue") +
  geom_point(aes(fill=as.factor(plot)), shape=21, size = 3) +
  labs(y = "Depth (cm)", x = NULL, fill = "Plot") +
  facet_wrap(transect~parameter, 
             scales = "free", ncol = 5) +
  theme_mb1() +
  scale_y_reverse() +
  #scale_x_continuous(position = "top") +
  scale_fill_manual(values = colors_young) +
  scale_color_manual(values = colors_young) 
  expand_limits(x = 0)


### OLD TRANSECT PLOTS ######
rbind(sampling_data_July, sampling_data_Mar) %>%
  subset(transect != "blank") %>%
  subset(parameter == "pH") %>%
  ggplot() +
  geom_boxplot(aes(x=as.factor(transect), y = result_value, fill = transect)) +
  #geom_hline(yintercept = 0, linetype = "dashed", color = "Blue") +
  #geom_point(aes(y = depth, x = result_value, fill=as.factor(plot)), shape=21, size = 3) +
  labs(y = "Depth (cm)", x = NULL, fill = "Plot") +
  #facet_grid(~transect, 
            #scales = "free") +
  theme_mb1() +
  #scale_y_reverse() +
  #cale_x_continuous(position = "top") +
  #scale_fill_manual(values = colors_young) +
  #scale_color_manual(values = colors_young) +
  expand_limits(x = 0)





