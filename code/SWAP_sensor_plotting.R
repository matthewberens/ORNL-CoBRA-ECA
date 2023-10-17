#############################################
# Plotting of CoBRA SWAP Sensor Data
# Matthew Berens
# Updated October 2023
#############################################
#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")


#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/SWAP Redox/processed")

#Load Data ---------------------------------------------------------------------
redox_old_2023 <- read.csv("combined_redox_old_2023") %>%
  mutate(DateTime = ymd_hms(DateTime))

redox_young_2023 <- read.csv("combined_redox_young_2023") %>%
mutate(DateTime = ymd_hms(DateTime))

###

#Line Plots ---------------------------------------------------------
redox_young_2023 %>%
  subset(plot == "1") %>%
  subset(redoxFLAG == "PASS") %>%
  ggplot(aes(x=DateTime, y=Avg+213, color=as.factor(depth))) +
  geom_line() +
  facet_wrap(~probe, nrow = 3) +
  theme_mb1() +
  scale_color_viridis(begin = 0, end = 0.9, direction = -1,discrete = TRUE, option = "plasma") +
  scale_x_datetime(date_breaks = "1 month" , date_labels = "%Y/%m")+
  labs(y = "Eh (mV)", x = NULL, color = "Depth (cm)")

#Contour Plots ---------------------------------------------------------

### YOUNG TRANSECT
#redox_Y1_plot <-
redox_young_2023 %>%
  subset(plot == "4") %>%
  subset(probe == "1") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-10 00:00:00'), as_datetime('2023-07-12 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  #facet_wrap(~probe, scales = "free_y", ncol = 1)+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 12, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

