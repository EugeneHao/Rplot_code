library(ggalt)
library(hrbrthemes)

mydata <- data.frame(type = LETTERS[1:6], 
                     pre = c(20, 40, 10, 30, 50, 60), 
                     post = c(70, 50, 30, 60, 80, 80))

ggplot(mydata, aes(y = type, x = pre, xend = post)) + 
  geom_dumbbell(size = 3, 
                colour = "grey85", # 连接两点的条带颜色
                colour_x = "firebrick", # pre的颜色
                colour_xend = "forestgreen", # post的颜色
                dot_guide = TRUE, 
                dot_guide_size = 0.5) +
  labs(x = "", 
       y = "", 
       title = "Dumbbell charts") + 
  theme_ipsum() +    # from hrbrthemes package
  theme(panel.grid.major.y = element_blank())