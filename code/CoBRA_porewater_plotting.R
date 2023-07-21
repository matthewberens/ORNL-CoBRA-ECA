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

sampling_data = read.csv("porewater data/processed/CoBRA POREWATER_Mar2023.csv") 


######################################
#Relative Water Level 
relative_wl_July2023 <- read.csv("porewater data/raw/CoBRA_water_level_July2023.csv") 
relative_wl_Mar2023 <- read.csv("porewater data/raw/CoBRA_water_level_Mar2023.csv") 

wl_all <- rbind(relative_wl_July2023, relative_wl_Mar2023) %>%
  mutate(date = lubridate::mdy(date),
         month = lubridate::month(date, label = TRUE))

wl_all %>%
  ggplot(aes(x = plot, y = -depth)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "Blue") +
  geom_point()+
  theme_mb1() +
  facet_wrap(transect~month, 
             nrow=2, 
             scales = "free_x") +
  labs(y = "Relative water level (cm)", x = "Plot") +
  theme(aspect.ratio = 0.5)





### OLD TRANSECT PLOTS ######
sampling_data %>%
  subset(transect != "blank") %>%
  subset(parameter %in% c("SpC", "pH", "ORP", "Fe_II")) %>%
  ggplot(aes(y=depth, x=result_value)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "Blue") +
  geom_point(aes(fill=as.factor(plot)), shape=21, size = 3) +
  labs(y = "Depth (cm)", x = NULL, fill = "Plot") +
  facet_grid(transect~parameter, 
             scales = "free",
             labeller = as_labeller(labels)) +
  theme_mb1() +
  scale_y_reverse() +
  #cale_x_continuous(position = "top") +
  #scale_fill_manual(values = colors_young) +
  #scale_color_manual(values = colors_young) +
  expand_limits(x = 0)














