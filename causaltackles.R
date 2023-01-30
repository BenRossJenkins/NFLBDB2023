library(ggplot2)
library(data.table)
library(ggpubr)


df <- fread('/Users/benjenkins/Documents/nfl-big-data-bowl-2023/causaltackles.csv')


fig1 <- 
  ggplot(df, aes(x = CLIPP, y = reorder(Player, CLIPP)))  + geom_bar(stat='identity', fill="lightgreen") +
  labs(
    x = "CLIPP",
    y = "Player",
    title = "Causal Top 10 Tackles"
  ) +  coord_cartesian(xlim = c(0.04, 0.045), expand = TRUE)
fig1 

correlationtackles <- fread('/Users/benjenkins/Documents/nfl-big-data-bowl-2023/correlatontackles.csv')

figure1 <- 
  ggplot(correlationtackles, aes(x = Mean, y = fct_rev(fct_reorder(Player, Mean))))  + geom_bar(stat='identity', fill="lightgreen") +
  labs(
    x = "Mean",
    y = "Player",
    title = "Correlation Top 10 Tackles"
  ) + coord_cartesian(xlim = c(0.07, 0.107), expand = TRUE)
figure1 


center <- fread('/Users/benjenkins/Documents/nfl-big-data-bowl-2023/causalcenters.csv')

fig2 <- 
  ggplot(center, aes(x = CLIPP, y = reorder(Player, CLIPP)))  + geom_bar(stat='identity', fill="lightgreen") +
  labs(
    x = "CLIPP",
    y = "Player",
    title = "Causal Top 10 Centers"
  ) +  coord_cartesian(xlim = c(0.06, 0.074), expand = TRUE)
fig2 

correlationcenters <- fread('/Users/benjenkins/Documents/nfl-big-data-bowl-2023/correlationcenters.csv')

figure2 <- 
  ggplot(correlationcenters, aes(x = Mean, y = fct_rev(fct_reorder(Player, Mean))))  + geom_bar(stat='identity', fill="lightgreen") +
  labs(
    x = "Mean",
    y = "Player",
    title = "Correlation Top 10 Centers"
  ) + coord_cartesian(xlim = c(0.03, 0.063), expand = TRUE)
figure2 



guard <- fread('/Users/benjenkins/Documents/nfl-big-data-bowl-2023/causalguards.csv')

fig3 <- 
  ggplot(guard, aes(x = CLIPP, y = reorder(Player, CLIPP)))  + geom_bar(stat='identity', fill="lightgreen") +
  labs(
    x = "CLIPP",
    y = "Player",
    title = "Causal Top 10 Guards"
  ) + coord_cartesian(xlim = c(0.05, 0.064), expand = TRUE)
fig3 


correlationguards <- fread('/Users/benjenkins/Documents/nfl-big-data-bowl-2023/correlationguards.csv')

figure3 <- 
  ggplot(correlationguards, aes(x = Mean, y = fct_rev(fct_reorder(Player, Mean))))  + geom_bar(stat='identity', fill="lightgreen") +
  labs(
    x = "Mean",
    y = "Player",
    title = "Correlation Top 10 Guards"
  ) + coord_cartesian(xlim = c(0.06, 0.079), expand = TRUE)
figure3 
                          
figure <- ggarrange(fig1, figure1, fig2, figure2, fig3, figure3,
                    #labels = c("A", "B", "C"),
                    ncol = 2, nrow = 3)
figure
