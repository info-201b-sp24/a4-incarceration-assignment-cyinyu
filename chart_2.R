library(ggplot2)
library(dplyr)
prison_wa <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv")
data2 <- prison_wa %>%
  filter(!is.na(total_jail_pop_rate)) %>%
  filter(!is.na(black_jail_pop_rate))

ggplot(data = data2, aes(x=total_jail_pop_rate, y=black_jail_pop_rate)) +
  geom_point(color="pink") +
  geom_smooth(method=lm, color="skyblue", se=FALSE) +
  labs(title = paste("Relationship Between Jail Population Rate and Black",
         "Jail Population Rate"),
       x = "Total Jail Population Rate (Unit: 0.01)",
       y = "Black Jail Population Rate (Unit: 0.01)")