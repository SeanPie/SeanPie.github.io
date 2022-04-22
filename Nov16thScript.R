#Nov 16th Lecture -- Mapping and spatial analysis

# Things you can do in R: Load in shapefiles, Do spatial statistics,
# Build maps,

# Leaflet package or ggmap library online have interactive maps that give examples codes that can be worked with. 
# Collection of charts - https://www.r-graph-gallery.com/

install.packages('usmap', dependencies = TRUE)
install.packages('gtrendsR', dependencies = TRUE)
install.packages('tidyverse', dependencies = TRUE)

library(tidyverse)
library(gtrendsR)
#searching through google for trends on what people are searching for.
library(usmap)

thanksgiving <- gtrends("thanksgiving", geo = "US", time= "now 1-d")
thanksgivingStates <-  thanksgiving$interest_by_region
thanksgivingStates$fips <- fips(thanksgivingStates$location)
#fips are assigned numbers for certain objects - each state is being assigned a fip number

orange <-  "#C9592E"
comp_blue <- "#2E9EC9"
purp <- "#7a49a5"
wine <- "#d20b60"

my_points <- data.frame(lon = -70.92694444, lat = 43.1338889)
my_points <-  usmap_transform(my_points)

plot_usmap(data = thanksgivingStates, values = "hits", color = wine, labels=FALSE) +
    scale_fill_continuous(low = comp_blue, high = wine, name = "Popularity", label = scales::comma) +
    theme(legend.position = "right") +
    theme(panel.background = element_rect(colour = "black")) +
    labs(title = "Popularity of Thanksgiving Google Search by State", caption = "Source: @eastonrwhite") +
    geom_point(data = my_points, aes(x=lon.1, y = lat.1))
