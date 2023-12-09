Codetmp <- data.frame(time = rep(2001:2020, 3), 
                  type = rep(c("Corn", "Soybean", "Rice"), each = 20), 
                  value = c(cumsum(runif(20)), 
                            (1:20)/5 + cumsum(runif(20)), 
                            (1:20)/2 + cumsum(runif(20))))

ggplot(data = tmp, aes(y = value, x = time, group = type,  shape = type, linetype = type)) + 
  geom_point()+
  geom_line()+
  xlab("Year") + ylab("Price")+
  theme_bw() +
  labs(group = "type")+
  theme(legend.title=element_blank(),legend.position="right") +
  geom_vline(aes(xintercept = 2016), color = "red", linetype = "dashed")
