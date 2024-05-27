library(ggplot2)
library(dplyr)
prison_wa <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv")

top_5_county <- prison_wa %>%
  filter(!is.na(black_jail_pop_rate)) %>%
  group_by(county_name) %>%
  summarize(mean_rate = mean(black_jail_pop_rate))%>%
  top_n(5, wt = mean_rate) %>%
  pull(county_name)

data1 <- prison_wa %>%
  group_by(year) %>%
  filter(county_name %in% top_5_county) %>%
  filter(!is.na(black_jail_pop_rate))

ggplot(data = data1, aes(x=year, y=black_jail_pop_rate, group=county_name, 
                         color=county_name)) + 
  geom_line() +
  labs(title = "Black jail population rate trends in top mean 5 counties",
       x = "Year", y = "Black Jail Population Rate (Unit: 0.01)", 
       color = "County Names") +
  scale_x_continuous(breaks = seq(1990, 2018, by=4))
 
  