#############################################
# Processing of CoBRA SWAP Sensor Data
# Matthew Berens
# Updated September 2023
#############################################
#Load libraries and packages
source("~/Documents/GitHub/ORNL-CoBRA-ECA/code/0-packages.R")


#Set directory to sensor of interest
setwd("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/SWAP Redox")


#YOUNG TRANSECT PLOTS 1 AND 2 -----------------------------------------
NAMES_redox_young_1_2 <- read_csv("42389_Young_1-2/20230711_DL42389_Young_1-2.csv", 
                      n_max = 2, 
                      col_names = FALSE,
                      show_col_types = FALSE) %>%
  summarise(across(.fns = paste, collapse = "_")) %>%
  unlist() %>% unname()

DATA_redox_young_1_2 <- read_csv("42389_Young_1-2/20230711_DL42389_Young_1-2.csv", 
                 skip = 2, 
                 col_names = NAMES_redox_young_1_2,
                 show_col_types = FALSE)

redox_young_1_2 <- DATA_redox_young_1_2 %>% pivot_longer(19:44, values_to = "raw_mV", names_to = "group_ID") %>%
  dplyr::select(TIMESTAMP_DateTime, raw_mV, group_ID) %>%
  #mutate(ID = sub('_[^_]*$', '', group_ID)) %>%
  separate(group_ID, sep = "_", into = c("transect", "plot_rep", "depth", "parameter")) %>%
  separate(plot_rep, sep = "-", into = c("plot", "probe")) %>%
  mutate(probe = as.numeric(probe), 
          probe = replace_na(probe, 1),
         plot = recode(plot, "Ref" = "0"),
         probe = ifelse(plot == "0", "1", probe)) %>%
  rename(DateTime = TIMESTAMP_DateTime) %>%
  mutate(DateTime = mdy_hm(DateTime)) %>%
  mutate(depth = gsub('[[:alpha:]]+', '', depth)) %>%
  mutate(depth = ifelse(as.numeric(depth) < 5, 0 , depth)) %>%
  pivot_wider(id_cols = c(DateTime, transect:depth), names_from = c("parameter"), values_from = "raw_mV") %>%
  mutate(redoxFLAG = ifelse(Std > 5, "FAIL", "PASS"))





###############################################################################
#YOUNG TRANSECT PLOTS 3 AND 4 -----------------------------------------
NAMES_redox_young_3_4 <- read_csv("42385_Young_3-4/20230824_DL42385_Young_3-4.csv", 
                                  n_max = 2, 
                                  col_names = FALSE,
                                  show_col_types = FALSE) %>%
  summarise(across(.fns = paste, collapse = "_")) %>%
  unlist() %>% unname()

DATA_redox_young_3_4 <- read_csv("42385_Young_3-4/20230824_DL42385_Young_3-4.csv",  
                                 skip = 2, 
                                 col_names = NAMES_redox_young_3_4,
                                 show_col_types = FALSE)

redox_young_3_4 <- DATA_redox_young_3_4 %>% pivot_longer(19:44, values_to = "raw_mV", names_to = "group_ID") %>%
  dplyr::select(TIMESTAMP_DateTime, raw_mV, group_ID) %>%
  #mutate(ID = sub('_[^_]*$', '', group_ID)) %>%
  separate(group_ID, sep = "_", into = c("transect", "plot_rep", "depth", "parameter")) %>%
  separate(plot_rep, sep = "-", into = c("plot", "probe")) %>%
  mutate(probe = as.numeric(probe), 
         probe = replace_na(probe, 1),
         plot = recode(plot, "Ref" = "0"),
         probe = ifelse(plot == "0", "2", probe)) %>%
  rename(DateTime = TIMESTAMP_DateTime) %>%
  mutate(DateTime = mdy_hm(DateTime)) %>%
  mutate(depth = gsub('[[:alpha:]]+', '', depth)) %>%
  mutate(depth = ifelse(as.numeric(depth) < 5, 0 , depth)) %>%
  pivot_wider(id_cols = c(DateTime, transect:depth), names_from = c("parameter"), values_from = "raw_mV") %>%
  mutate(redoxFLAG = ifelse(Std > 5, "FAIL", "PASS"))

#Save combined young transect data
combined_redox_young_2023 <- rbind(redox_young_1_2, redox_young_3_4)

#Export Young Transect Data
write.csv(combined_redox_young_2023, "processed/combined_redox_young_2023", row.names = FALSE)








###############################################################################
#OLD TRANSECT PLOTS 2 AND 3  -----------------------------------------
NAMES_redox_old_2_3 <- read_csv("42391_Old_2-3/20231017_DL42391_Old_2-3.csv", 
                                  n_max = 2, 
                                  col_names = FALSE,
                                  show_col_types = FALSE) %>%
  summarise(across(.fns = paste, collapse = "_")) %>%
  unlist() %>% unname()

DATA_redox_old_2_3 <- read_csv("42391_Old_2-3/20231017_DL42391_Old_2-3.csv",  
                                 skip = 2, 
                                 col_names = NAMES_redox_old_2_3,
                                 show_col_types = FALSE)

redox_old_2_3 <- DATA_redox_old_2_3 %>% pivot_longer(19:44, values_to = "raw_mV", names_to = "group_ID") %>%
  dplyr::select(TIMESTAMP_DateTime, raw_mV, group_ID) %>%
  #mutate(ID = sub('_[^_]*$', '', group_ID)) %>%
  separate(group_ID, sep = "_", into = c("transect", "plot_rep", "depth", "parameter")) %>%
  separate(plot_rep, sep = "-", into = c("plot", "probe")) %>%
  mutate(probe = as.numeric(probe), 
         probe = replace_na(probe, 1),
         plot = recode(plot, "Ref" = "0"),
         probe = ifelse(plot == "0", "1", probe)) %>%
  rename(DateTime = TIMESTAMP_DateTime) %>%
  mutate(DateTime = mdy_hm(DateTime)) %>%
  mutate(depth = gsub('[[:alpha:]]+', '', depth)) %>%
  mutate(depth = ifelse(as.numeric(depth) < 5, 0 , depth)) %>%
  pivot_wider(id_cols = c(DateTime, transect:depth), names_from = c("parameter"), values_from = "raw_mV") %>%
  mutate(redoxFLAG = ifelse(Std > 5, "FAIL", "PASS"))

#Save combined old transect data
combined_redox_old_2023 <- rbind(redox_old_2_3)

#Export Young Transect Data
write.csv(combined_redox_old_2023, "processed/combined_redox_old_2023", row.names = FALSE)



