#############################################
# Plotting of HOBO Water Level Sensor Data
# Matthew Berens
# Updated October 2023
#############################################
#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")


#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data")


#Load Data ---------------------------------------------------------------------
WLD_water_level_2023 <- read.csv("HOBO Water Level/processed/combined_depth_2023") %>%
  mutate(DateTime = ymd_hms(DateTime)) %>%
  na.omit()

WLD_conductivity_2023 <- read_csv("HOBO Conductivity/processed/combined_conductivity_2023.csv") %>%
  mutate(DateTime = ymd_hms(DateTime)) %>%
  na.omit()

redox_old_2023 <- read.csv("SWAP Redox/processed/combined_redox_old_2023") %>%
  mutate(DateTime = ymd_hms(DateTime)) %>%
  na.omit()

redox_young_2023 <- read.csv("SWAP Redox/processed/combined_redox_young_2023") %>%
  mutate(DateTime = ymd_hms(DateTime)) %>%
  na.omit()

pH_young_1_2023 <- read.csv("HOBO pH/processed/summary pH_Young_1.csv") %>%
  mutate(DateTime = ymd_hms(DateTime)) %>%
  na.omit()

P92 <- read.csv("P92.csv") %>%
  mutate(DateTime = dmy_hm(DateTime))



redox_Y1_plot <-
redox_young_2023 %>%
  subset(plot == "1") %>%
  subset(probe == "1") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 10, vjust = 0.5), legend.position = "none",
         panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())


redox_Y2_1_plot <-
  redox_young_2023 %>%
  subset(plot == "2") %>%
  subset(probe == "1") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 12, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())


redox_Y2_2_plot <-
  redox_young_2023 %>%
  subset(plot == "2") %>%
  subset(probe == "2") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 12, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

redox_Y3_1_plot <-
  redox_young_2023 %>%
  subset(plot == "3") %>%
  subset(probe == "1") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 12, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

redox_Y3_2_plot <-
  redox_young_2023 %>%
  subset(plot == "3") %>%
  subset(probe == "2") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 12, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

redox_Y4_1_plot <-
  redox_young_2023 %>%
  subset(plot == "4") %>%
  subset(probe == "1") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 12, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())



depth_Y1_2023 <-
WLD_water_level_2023 %>%
  subset(transect == "Young") %>%
  subset(plot == "1") %>%
  subset(pressure_kPa > 103) %>%
  ggplot(aes(x=DateTime,y=pressure_kPa)) +
  geom_line(aes(color = plot), color = "black")+
  geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_void() +
  labs(y = "Depth (cm)", x = NULL)+
  theme(axis.text.x = element_blank(),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

depth_Y3_2023 <-
  WLD_water_level_2023 %>%
  subset(transect == "Young") %>%
  subset(plot == "3") %>%
  subset(pressure_kPa > 105) %>%
  ggplot(aes(x=DateTime,y=pressure_kPa)) +
  geom_line(aes(color = plot), color = "black")+
  geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_void() +
  labs(y = "Depth (cm)", x = NULL)+
  theme(axis.text.x = element_blank(),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())





cowplot::plot_grid(depth_Y1_2023, redox_Y1_plot, ncol = 1, align = "v", rel_heights = c(1,4))


postscript("f/precip.eps", width = 12, height = 9, horizontal = FALSE, 
           onefile = FALSE)
dev.off()

ggsave(plot = last_plot(), "f/redox_depth.eps", width = 12, height = 9, units = "in")

cowplot::plot_grid(depth_Y1_2023, redox_Y2_1_plot, ncol = 1, align = "v", rel_heights = c(1,4))

cowplot::plot_grid(depth_Y1_2023, redox_Y2_2_plot, ncol = 1, align = "v", rel_heights = c(1,4))

cowplot::plot_grid(depth_Y3_2023, redox_Y3_1_plot, ncol = 1, align = "v", rel_heights = c(1,4))

cowplot::plot_grid(depth_Y3_2023, redox_Y3_2_plot, ncol = 1, align = "v", rel_heights = c(1,4))

cowplot::plot_grid(depth_Y3_2023, redox_Y4_1_plot, ncol = 1, align = "v", rel_heights = c(1,4))


##############################################################################
redox_old_2023 %>%
  subset(plot == "0") %>%
  #subset(probe == "1") %>%
  ggplot(aes(x=DateTime, y =Avg)) +
  geom_line() +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  #scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  facet_wrap(~probe, scales = "free_y", ncol = 1)+
  scale_y_continuous(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 10, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())


redox_O2_plot <-
  redox_old_2023 %>%
  subset(plot == "2") %>%
  subset(probe == "1") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-05-24 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 10, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())


redox_O3_1_plot <-
  redox_old_2023 %>%
  subset(plot == "3") %>%
  subset(probe == "1") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 10, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())


redox_O3_2_plot <-
  redox_old_2023 %>%
  subset(plot == "3") %>%
  subset(probe == "2") %>%
  ggplot(aes(x=DateTime, y = as.numeric(depth), z=Avg+213)) +
  geom_contour_fill(na.fill = TRUE) +
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  scale_fill_gradientn(colors=pnw_palette("Bay"))+
  labs(x = "2023", y = NULL,
       fill = "Eh (mV)")+
  scale_y_reverse(expand = c(0,0))+
  theme_mb1() +
  theme(axis.text.x = element_text(size = 10, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())


depth_O1_2023 <-
  WLD_water_level_2023 %>%
  subset(transect == "Old") %>%
  subset(plot == "1") %>%
  subset(pressure_kPa > 105) %>%
  ggplot(aes(x=DateTime,y=pressure_kPa)) +
  geom_line(aes(color = plot), color = "black")+
  geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_void() +
  labs(y = "Depth (cm)", x = NULL)+
  theme(axis.text.x = element_blank(),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

depth_O4_2023 <-
  WLD_water_level_2023 %>%
  subset(transect == "Old") %>%
  subset(plot == "4") %>%
  subset(pressure_kPa > 105) %>%
  ggplot(aes(x=DateTime,y=pressure_kPa)) +
  geom_line(aes(color = plot), color = "black")+
  geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_void() +
  labs(y = "Depth (cm)", x = NULL)+
  theme(axis.text.x = element_blank(),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())
  
  
cowplot::plot_grid(depth_O1_2023, redox_O2_plot, ncol = 1, align = "v", rel_heights = c(1,4))


##############################################################################
conductivity_O1_plot <-
  WLD_conductivity_2023 %>%
  subset(transect == "Old") %>%
  subset(plot == "1") %>%
  subset(adjusted_SpC > 1000) %>%
  ggplot(aes(x=DateTime,y=adjusted_SpC)) +
  geom_line(aes(color = plot), color = "black")+
  #geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_mb1() +
  labs(y = "Conductivity (uS/cm)", x = NULL)+
  theme(axis.text.x = element_text(size = 10, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

conductivity_O4_plot <-
  WLD_conductivity_2023 %>%
  subset(transect == "Old") %>%
  subset(plot == "4") %>%
  subset(adjusted_SpC > 1000) %>%
  ggplot(aes(x=DateTime,y=adjusted_SpC)) +
  geom_line(aes(color = plot), color = "black")+
  #geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_mb1() +
  labs(y = "Conductivity (uS/cm)", x = NULL)+
  theme(axis.text.x = element_text(size = 10, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

conductivity_Y1_plot <-
  WLD_conductivity_2023 %>%
  subset(transect == "Young") %>%
  subset(plot == "1") %>%
  subset(adjusted_SpC > 1000) %>%
  ggplot(aes(x=DateTime,y=adjusted_SpC)) +
  geom_line(aes(color = plot), color = "black")+
  #geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_mb1() +
  labs(y = NULL, x = NULL)+
  theme(axis.text.x = element_blank(),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

conductivity_Y3_plot <-
  WLD_conductivity_2023 %>%
  subset(transect == "Young") %>%
  subset(plot == "3") %>%
  subset(adjusted_SpC > 1000) %>%
  ggplot(aes(x=DateTime,y=adjusted_SpC)) +
  geom_line(aes(color = plot), color = "black")+
  #geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_mb1() +
  labs(y = "Conductivity (uS/cm)", x = NULL)+
  theme(axis.text.x = element_blank(),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

conductivity_Y4_plot <-
  WLD_conductivity_2023 %>%
  subset(transect == "Young") %>%
  subset(plot == "4") %>%
  subset(adjusted_SpC > 1000) %>%
  ggplot(aes(x=DateTime,y=adjusted_SpC)) +
  geom_line(aes(color = plot), color = "black")+
  #geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_mb1() +
  labs(y = "Conductivity (uS/cm)", x = NULL)+
  theme(axis.text.x = element_text(size = 10, vjust = 0.5),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())


cowplot::plot_grid(depth_O1_2023, conductivity_O1_plot, ncol = 1, align = "v", rel_heights = c(1,2))

cowplot::plot_grid(depth_O1_2023, conductivity_O4_plot, ncol = 1, align = "v", rel_heights = c(1,2))

cowplot::plot_grid(depth_Y1_2023, conductivity_Y1_plot, ncol = 1, align = "v", rel_heights = c(1,2))

cowplot::plot_grid(depth_Y3_2023, conductivity_Y3_plot, ncol = 1, align = "v", rel_heights = c(1,2))

cowplot::plot_grid(depth_Y3_2023, conductivity_Y4_plot, ncol = 1, align = "v", rel_heights = c(1,2))






#conductivity_Y1_plot <-
  pH_young_1_2023 %>%
  subset(transect == "Young") %>%
  subset(plot == "1") %>%
  subset(pH < 8) %>%
  ggplot(aes(x=DateTime,y=pH)) +
  geom_line(aes(color = plot), color = "black")+
  #geom_smooth(method = "gam")+
  scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00:00'), as_datetime('2023-07-11 00:00:00')))+
  theme_mb1() +
  labs(y = NULL, x = NULL)+
  theme(axis.text.x = element_blank(),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())

P92 %>%
    ggplot() +
    geom_bar(aes(x=DateTime,y=p01i), stat = "identity", color = "black")+
    #geom_smooth(method = "gam")+
    scale_x_datetime(date_breaks = "2 weeks", date_labels = "%b-%d", expand = c(0,0), limits = c(as_datetime('2023-03-12 00:00'), as_datetime('2023-07-11 00:00')))+
    theme_mb1() +
    labs(y = NULL, x = NULL) +
    theme(axis.text.x = element_blank(),
        legend.position = "none", panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank())




