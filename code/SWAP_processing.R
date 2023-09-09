#############################################
# Processing of CoBRA SWAP Sensor Data
# Matthew Berens
# Updated September 2023
#############################################
#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")


#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/SWAP Redox")


# Step 1. Load Data ---------------------------------------------------------------------
data_names <- read_csv("42389_Young_1-2/20230711_DL42389_Young_1-2.csv", 
                      n_max = 2, 
                      col_names = FALSE,
                      show_col_types = FALSE) %>%
  summarise(across(.fns = paste, collapse = "_")) %>%
  unlist() %>% unname()

data <- read_csv("42389_Young_1-2/20230711_DL42389_Young_1-2.csv", 
                 skip = 2, 
                 col_names = data_names,
                 show_col_types = FALSE)

# Step 2. Set names and reshape data columns  ----------------------------------------------------

data_long <- data %>% pivot_longer(19:44, values_to = "raw_mV", names_to = "group_ID") %>%
  dplyr::select(TIMESTAMP_DateTime, raw_mV, group_ID) %>%
  mutate(ID = sub('_[^_]*$', '', group_ID))


data_long <- cbind(data_long, str_split_fixed(data_long$group_ID, "_", n=4))

names(data_long)<-c("DateTime","raw_mV","group_ID", "ID", "transect", "plot", "depth", "parameter")

data_long <- data_long %>%
  mutate(depth = gsub('[[:alpha:]]+', '', depth),
         DateTime = mdy_hm(DateTime))

raw_summary <- data_long %>%
  tidyr::pivot_wider(id_cols = c(DateTime, ID:depth), names_from = c("parameter"), values_from = "raw_mV")


# Step 3. QAQC data ---------------------------------------------------------
processed_summary <-
  raw_summary %>%
  mutate(redoxFLAG = ifelse(Std > (max(raw_summary$Avg)-min(raw_summary$Avg))*0.1, "FAIL", "PASS"))

write.csv(processed_summary, "processed/20230711_DL42389_processed",row.names = F)

# Step 4. Visualize data ---------------------------------------------------------
#Set directory for plots
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/SWAP Redox/processed")

processed_summary %>%
subset(plot != "Ref") %>%
subset(redoxFLAG == "PASS") %>%
ggplot(aes(x=DateTime, y=Avg+213, color=depth)) +
  geom_line() +
  facet_wrap(~plot, nrow = 3) +
  theme_mb1() +
  scale_color_viridis(begin = 0, end = 0.9, direction = -1,discrete = TRUE, option = "plasma") +
  scale_x_datetime(date_breaks = "1 month" , date_labels = "%Y/%m")+
  labs(y = "ORV (mV vs. SHE)", x = NULL, color = "Depth (cm)", title = processed_summary$transect[1])


ggsave(plot = last_plot(), "f/Redox Young 1-2.png", width = 9, unit = "in")
