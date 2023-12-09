set.seed(123)

data.frame(value = rnorm(12, mean = 0, sd = 0.05)) %>% 
  mutate(lower = value - runif(12, 0, 0.4), 
         upper = value + runif(12, 0, 0.4), 
         REG = rep(c("A", "B", "C", "D"), 3), 
         est = mean(value), 
         index = rep(1:3, each = 4)) %>% 
  ggplot(aes(x = lower, xend = upper, 
             y = index + rep((0:(length(unique(REG))-1))/10, 3), 
             yend = index + rep((0:(length(unique(REG))-1))/10, 3), 
             color = REG)) + 
  geom_segment(lwd = 1, alpha = 0.5) + 
  scale_color_brewer(palette = "Set1") + 
  labs(y = "", x = "Reduction Rate") + 
  scale_y_continuous(breaks = 1:3, 
                     labels = c("method 1", "method 2", "method 3")) + 
  geom_segment(aes(x = est, xend = est, 
                   y = index - 0.1, 
                   yend = index + (length(unique(REG)))/10)) + 
  geom_point(aes(x = value, 
                 y = index + rep((0:(length(unique(REG))-1))/10,  3))) + 
  theme_bw() + 
  ggtitle("Reduction Rate of Treatment Compared With Placebo") + 
  theme(plot.title = element_text(hjust = 0.5), 
        text= element_text(size = 15))
