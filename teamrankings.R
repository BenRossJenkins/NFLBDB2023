library(ggplot2)
library(data.table)

asp_ratio <- 1.618

df <- fread('/Users/benjenkins/Documents/nfl-big-data-bowl-2023/CLIPteam.csv')
summary(df)

mids <- mean(df$CLIPP) 

fig1 <- 
  ggplot(df, aes(x = CLIPP, y = reorder(Team, CLIPP)))  + geom_bar(stat='identity', fill="lightgreen") +
  labs(
    x = "CLIPP",
    y = "Team",
    title = "CLIPP Rankings of Offensive Lines",
    cex.main = 6
  ) 
fig1 + coord_cartesian(xlim = c(0.1, 0.222), expand = TRUE) + 
  geom_vline(xintercept=mids, linetype='dashed', col = 'red') +
  theme(axis.text = element_text(face="bold")) +
  annotate("text", x=0.18, y=5, label="Average", angle=90, size=5, color="red")

#+ scale_x_continuous(limits = c(0, 0.1), breaks=(seq(0.1, 0.24, 0.01))) 




