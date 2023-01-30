library(ggimage)
library(data.table)

asp_ratio <- 1.618


df <- fread('/Users/benjenkins/Documents/nfl-big-data-bowl-2023/pffteamrank.csv')
summary(df)

epa_logos <- df %>%
  left_join(nflfastR::teams_colors_logos, by = c("Team" = "team_abbr")) %>% 
  ggplot(aes(x = Rank, y = PFFrank)) +
  geom_image(aes(image = team_logo_wikipedia), size = 0.035, by = "width", asp = asp_ratio) +
  scale_fill_identity(aesthetics = c("fill", "colour")) +
  theme(
    aspect.ratio = 1/asp_ratio
  ) +
  labs(
    x = "CLIPP Ranking",
    y = "PFF Ranking",
    title = "CLIPP Rankings vs Pro Football Focus (PFF) Rankings"
  ) + geom_abline(intercept = 0, slope = 1) +
annotate("text", x = 4, y = 28, label = "CLIPP ranks higher") +
  annotate("text", x = 28, y = 9, label = "CLIPP ranks lower")

epa_logos




epa_logos <- df %>%
  left_join(nflfastR::teams_colors_logos, by = c("Team" = "team_abbr")) 



fig1 <- 
  ggplot(epa_logos, aes(x = Rank, y = reorder(Team, PFFrank))) +
  geom_image(aes(image = team_logo_wikipedia), size = 0.035, by = "width", asp = asp_ratio) +
  scale_fill_identity(aesthetics = c("fill", "colour")) +
  theme(
    panel.grid.major.y = element_blank(),
    axis.text.y = element_blank(),
    aspect.ratio = 1/asp_ratio
  ) +
  labs(
    x = "CLIPP Ranking",
    y = "PFF Ranking",
    title = "CLIPP Rankings vs Pro Football Focus (PFF) Rankings"
  )
fig1
