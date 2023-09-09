#############################################
# Processing of CoBRA SWAP Sensor Data
# Matthew Berens
# Updated September 2023
#############################################
#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")


#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/SWAP Redox/processed")


# Step 1. Load Data ---------------------------------------------------------------------
DL42391_Old_2_3 <- read.csv("20230824_DL42391_processed")

DL42389_Young_1_2 <- read.csv("20230711_DL42389_processed")

DL42385_Young_3_4 <- read.csv("20230824_DL42385_processed")


# Step 4. Visualize data ---------------------------------------------------------
DL42391_Old_2_3 %>%
subset(plot != "Ref") %>%
subset(redoxFLAG == "PASS") %>%
ggplot(aes(x=ymd_hm(DateTime), y=Avg+213, color=depth)) +
  geom_line() +
  facet_wrap(~plot, nrow = 3) +
  theme_mb1() +
  scale_color_viridis(begin = 0, end = 0.9, direction = -1,discrete = TRUE, option = "plasma") +
  scale_x_datetime(date_breaks = "1 month" , date_labels = "%Y/%m")+
  labs(y = "ORV (mV vs. SHE)", x = NULL, color = "Depth (cm)")


write.csv(processed_summary,"~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/SWAP Redox/processed/20230824_DL42391_processed",row.names = F)
