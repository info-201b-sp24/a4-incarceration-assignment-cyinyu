library(dplyr)
library(ggplot2)
library(mapproj)
library(maps)

prison_wa <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv")

map_wa <- prison_wa %>%
  filter(year < 2017) %>%
  mutate(county = tolower(gsub("\\s.*", "", county_name))) %>%
  filter(!is.na(white_prison_pop_rate)) %>%
  group_by(county) %>%
  summarize(avg_white_rate = mean(white_prison_pop_rate)) %>%
  select(county, avg_white_rate)

county_shape <- map_data("county") %>%
  filter(region == "washington") %>%
  rename(county = subregion) %>%
  left_join(map_wa, by = "county")
  

ggplot(county_shape) +
  geom_polygon(
    mapping = aes(x=long, y=lat, group = group, 
                  fill = avg_white_rate),
    color = "white",
    size = .1
  ) +
  coord_map() +
  scale_fill_continuous(low = "grey90", high = "darkgreen") +
  labs(title = paste("Average White Prison Population Rate in Each County",
                     "in Washington"),
       fill = "Average White Prison Population Rate (Unit:0.01)", 
       x = "Longitude", 
       y = "Latitude") +
  theme_minimal()





