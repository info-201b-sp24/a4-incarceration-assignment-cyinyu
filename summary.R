library(dplyr)
prison_wa <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv")
View(prison_wa)

summary_info <- list() 
summary_info$num_county <- prison_wa %>%
  filter(year == max(year)) %>%
  summarize(num = n()) %>%
  pull(num)
summary_info$max_jail_rate <- prison_wa %>%
  filter(total_jail_pop_rate == max(total_jail_pop_rate, na.rm = TRUE)) %>%
  pull(total_jail_pop_rate)
summary_info$max_jail_rate_black <- prison_wa %>%
  filter(total_jail_pop_rate == max(black_jail_pop_rate, na.rm = TRUE)) %>%
  pull(total_jail_pop_rate)
summary_info$max_jail_rate_black_county <- prison_wa %>%
  filter(total_jail_pop_rate == max(black_jail_pop_rate, na.rm = TRUE)) %>%
  pull(county_name)
summary_info$diff_max_race_jail_rate <- prison_wa %>%
  filter(year == max(year)) %>%
  summarize(max_diff = max(black_jail_pop_rate, na.rm = TRUE) -
              max(white_jail_pop_rate, na.rm = TRUE)) %>%
  pull(max_diff)
summary_info$recent_avg_jail_rate_white <- prison_wa %>%
  filter(year == max(year)) %>%
  summarize(avg_rate = mean(white_jail_pop_rate, na.rm = TRUE)) %>%
  pull(avg_rate)
summary_info$recent_avg_jail_rate_black <- prison_wa %>%
  filter(year == max(year)) %>%
  summarize(avg_rate = mean(black_jail_pop_rate, na.rm = TRUE)) %>%
  pull(avg_rate)
summary_info$change_avg_black_jail_rate <- prison_wa %>%
  group_by(year) %>%
  summarize(avg_rate = mean(black_jail_pop_rate, na.rm = TRUE)) %>%
  filter(year == max(year) | year == min(year)) %>%
  summarize(change = diff(avg_rate)) %>%
  pull(change)






ex1 <- prison_wa %>%
  group_by(year) %>%
  summarize(avg_rate = mean(total_jail_pop_rate)) %>%
  filter(year == max(year) | year == min(year)) %>%
  summarize(change = diff(avg_rate))
View(ex1)
View(summary_info)