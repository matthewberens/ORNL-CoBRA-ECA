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

sampling_data = read.csv("porewater data/raw/CoBRA_porewater_July2023.csv") 



# Step 2. Calculate Parameters  ----------------------------------------------------------------

sampling_data$DIC = sampling_data$TC - sampling_data$DOC
sampling_data$CaMg = sampling_data$Mg + sampling_data$Ca



# Step 3. Format Date and Time  ---------------------------------------------------------

sampling_data <- sampling_data %>%
  mutate(sample_date = lubridate::mdy(sample_date),
         sample_time = lubridate::hm(sample_time),
         Year = lubridate::year(sample_date),
         DOY = lubridate::yday(sample_date))



# Step 4. Transform data and reshape data -----------------------------------------------

data_transform <- sampling_data %>%
  pivot_longer(-c("sampleID":"depth", "Year","DOY"), values_to = "result_value", names_to = "parameter") 



# Step 5. Determine detection limit flags -----------------------------------------------

#Read in instrument detection limits
CoBRA_ddl = read.csv("porewater data/raw/CoBRA DETECTION LIMITS.csv") 

#Merge ddls with analytical results and determine if flagged
data_LOD <- left_join(data_transform, CoBRA_ddl, by = "parameter") %>%
  mutate(detection_FLAG = ifelse(result_value < ddl, "<", "NONE"),
         result_value = ifelse(detection_FLAG == "<", ddl/2, result_value))

# Step 6. Export processed data as csv --------------------------------------------------

#Save formatted data as a .csv
write.csv(data_LOD, "porewater data/processed/CoBRA POREWATER_July2023.csv", row.names = FALSE)
  


