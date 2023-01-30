getwd()=='/Users/benjenkins'
library(data.table)

library(ggplot2)

library(gt)
library("gridExtra")   
library(magick)
library(data.table)
library(caret)
library(corrplot)
library(yardstick) 
library(tidyverse)
library(gbm)
library(visreg)
library(MLeval)
library(ROCR)
library(iml)
library(ggplot2)
library(gganimate)
theme_set(theme_bw())
library(wesanderson)
library(grid)
library(ggvoronoi)




df <- fread('Documents/nfl-big-data-bowl-2023/pressureplay.csv')
summary(df)

#df <- df[df$gameId == 2021090900 & df$playId == 97,]

#df <- df[df$pff_role == 'Pass Block']

mids <- mean(df$CLIPPteam) 

team <- ggplot(
  df,
  aes(frameId, CLIPPteam, group = frameId)) +
  labs(x = "Play", y = "CLIPP")  +
  theme(legend.position = "right") +
  theme(text = element_text(size = 20)) +
  transition_reveal(frameId)  + 
  geom_point(aes(color = CLIPPteam), size=4) +
  scale_color_gradient2(midpoint = mids, low = "blue", mid = "purple",
                        high = "green", space = "Lab" ) + 
  geom_hline(yintercept = 0, color="black", size = 1) +
  ggtitle('CLIPP of Entire Offensive Line', subtitle = 'Frame {frame} of {nframes}')

team

c_gif <- animate(team, width = 550, height = 550)

mid <- mean(df$CLIPP) 

sp2 <- ggplot(df, aes(x, y, group = displayName))+
  geom_point(aes(color = CLIPP), size=4) +   
  theme(text = element_text(size = 20)) +
  #geom_hline(yintercept = 19, color="black")  +
  scale_color_gradient2(midpoint = mid, low = "red", mid = "white",
                            high = "green", space = "Lab" ) + 
  transition_reveal(frameId) +
  ggtitle('CLIPP of Offensive Line Movements', subtitle = 'Frame {frame} of {nframes}')  +
  #view_follow(fixed_x = TRUE) + 
  shadow_wake(wake_length = 1,
              alpha = 1)+
  labs(x = "Long Axis of Field (x) ", y = "Short Axis of Field (y)") 

sp2


a_gif <- animate(sp2, width = 550, height = 550)



p <- ggplot(
  df,
  aes(frameId, CLIPP, group = displayName, color = displayName)) +
  geom_line() +
   theme(text = element_text(size = 20)) +
  scale_fill_manual(values = wes_palette("Rushmore1", n = 5)) +
labs(x = "Play", y = "CLIPP")  +
  theme(legend.position = "right") +
  geom_point() + transition_reveal(frameId) + geom_hline(yintercept = 0, color="black", size = 1)  +
  ggtitle('CLIPP of Each Offensive Linemen', subtitle = 'Frame {frame} of {nframes}')

p

b_gif <- animate(p, width = 550, height = 550)

a_mgif <- image_read(a_gif)
b_mgif <- image_read(b_gif)
c_mgif <- image_read(c_gif)

new_gif <- image_append(c(a_mgif[1], b_mgif[1], c_mgif[1]))
for(i in 3:100){
  combined <- image_append(c(a_mgif[i], b_mgif[i], c_mgif[i]))
  new_gif <- c(new_gif, combined)
}

new_gif




# Static Images

sp2 <- ggplot(df, aes(y, x, group = displayName))+
  geom_point(aes(color = CLIPP), size=2)
mid <- mean(df$CLIP) 
sp2 + scale_color_gradient2(midpoint = mid, low = "blue", mid = "white",
                            high = "red", space = "Lab" )  +
  ggtitle('CLIPP Example')  +
  labs(x = "Short Axis of Field (y) ", y = "Long Axis of Field (x)") +
  geom_hline(yintercept = 42, color="black")  