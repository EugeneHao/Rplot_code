conser <- data.frame(type = rep(c("A", "B", "C", "D"), each = 3), 
                     ratio = c(0.1, 0.2, 0.7, 
                               0.2, 0.3, 0.5,
                               0.3, 0.1, 0.6,
                               0.5, 0.2, 0.3), 
                     answer = rep(c("a", "b", "c"), 4))
conser %>% 
  ggplot( aes(x = type, y = ratio, fill = answer)) + 
  geom_col(color = "black", size = 0.2)+
  theme_bw()+
  xlab("") + 
  ylab("Percent (%)") +
  theme(legend.title=element_blank(),legend.position="bottom") +
  scale_fill_manual(values = c("#AED6F1", "#3498DB","#21618C"), labels = c("Not Used", "Not sure", "Used"))+
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 10))+
  theme(axis.text.x = element_text(size = 11))
