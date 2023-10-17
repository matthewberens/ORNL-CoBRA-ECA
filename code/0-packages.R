#Functions and Packages
#CoBRA Sensor Processing
#Matthew J Berens

# packages
library(tidyverse)
library(viridis)
library(ggthemes)
library(stats)
library(cowplot)
library(janitor)
library(lubridate)     # 1.6.0
library(cowplot)
library(knitr)
library(reshape2)
library(ggExtra)
library(stringi)
library(raster)
library(reshape2)
library(magrittr)
library(ggnewscale)
library(metR)
library(PNWColors)

#sensorList<-read.csv("~/Documents/GitHub/ORNL-CoBRA-ECA/sensor data/CoBRA SENSORS LIST.csv")

# functions 
theme_mb1 <- function() {  # this for all the elements common across plots
  theme_bw() %+replace%
    theme(legend.position = "right",
          legend.key=element_blank(),
          #legend.title = element_blank(),
          legend.text = element_text(size = 12),
          legend.key.size = unit(1.5, 'lines'),
          panel.border = element_rect(color="black",size=1, fill = NA),
          panel.grid = element_blank(),
          
          plot.title = element_text(hjust = 0.5, size = 12),
          plot.subtitle = element_text(hjust = 0.5, size = 12, lineheight = 1.5),
          axis.text = element_text(size = 12, color = "black"),
          axis.title = element_text(size = 12, face = "bold", color = "black"),
          
          # formatting for facets
          panel.background = element_blank(),
          strip.background = element_rect(colour="white", fill="white"), #facet formatting
          panel.spacing.x = unit(1.5, "lines"), #facet spacing for x axis
          panel.spacing.y = unit(1.5, "lines"), #facet spacing for x axis
          strip.text.x = element_text(size=12, face="bold"), #facet labels
          strip.text.y = element_text(size=12, face="bold", angle = 270) #facet labels
    )
  
}
