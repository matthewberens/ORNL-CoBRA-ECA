#############################################
# Processing of CoBRA HOBO Sensor Data
# Matthew Berens
# Updated June 2023
#############################################

#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")

#Set directory to sensor of interest
setwd("~/Downloads")



# Step 1. Load Data ---------------------------------------------------------------------

data_head <- read_csv("demo_csv.csv", 
                      n_max = 2, 
                      col_names = FALSE)

new_names <- data_head %>%
  summarise(across(.fns = paste, collapse = "_")) %>%
  unlist() %>% unname()

data <- read_csv("demo_csv.csv", 
                 skip = 2, 
                 col_names = new_names,
                 show_col_types = FALSE)

# Step 2. Set names of data columns  ----------------------------------------------------

data_long <- data %>% pivot_longer(19:44, values_to = "value", names_to = "names") %>%
  dplyr::select(TIMESTAMP_DateTime, value, names) %>%
  mutate(ID = sub('_[^_]*$', '', names))
  

ids <- str_split_fixed(data_long$names, "_", n=4)

data_long <- cbind(data_long, ids)

names(data_long)<-c("DateTime","value","name", "ID", "transect", "plot", "depth", "parameter")

data_long <- data_long %>%
  mutate(depth = gsub('[[:alpha:]]+', '', depth),
         DateTime = mdy_hm(DateTime))


pivot <- data_long %>%
  pivot_wider(names_from = "parameter", values_from = "value")

# Step 5. Visually check data ---------------------------------------------------------
ggplot(data_long,aes(x=DateTime,y=value, color=depth)) +
  geom_line()+
  facet_wrap(~plot, scales = "free_y") +
  theme_mb1()


write.csv(sensor_data,"~/Documents/CoBRA-ECA/data/sensor data/output/SpC_WLD_2023.csv",row.names = F)
