#############################################
# CoBRA Sampling Data Processing
# Matthew Berens
# Updated June 2023
#############################################

#Load libraries and set directory
setwd("~/Documents/CoBRA-ECA")

#load packages
source("code/0-packages.R")

# Step 1. Load Data ---------------------------------------------------------------------

sampling_data = read.csv("data/porewater/processed/CoBRA POREWATER_July2023.csv") 



#Define Color Scheme
##############################################
colors_old <- c("1" = "#C85E6D", "2" = "#EDA150", "3" = "#F4CA4E", "4" = "#6811A2", "5" = "#3F0898", "6" = "#0B0780")
colors_young <- c("1" = "#C85E6D", "2" = "#F4CA4E", "3" = "#6811A2", "4" = "#0B0780")
##############################################


######################################
#Relative Water Level March 2023
relative_wl <- read.csv("data/porewater/CoBRA_water_level_Mar2023.csv") 

relative_wl %>%
  ggplot(aes(x = plot, y = -depth_cm)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "Blue") +
  stat_summary(fun.y = "mean", geom = "point") +
  stat_summary(fun.y = "mean", geom = "line") +
  stat_summary(fun.data = "mean_se", geom = "errorbar", width = 0.1) +
  theme_mb() +
  facet_wrap(.~transect, 
             nrow=2, 
             scales = "free_x",
             labeller = as_labeller(labels)) +
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














