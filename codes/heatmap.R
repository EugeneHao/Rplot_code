ggplot(airquality, aes(Day, Month, fill = Temp)) + 
  geom_tile() + 
  scale_x_continuous(breaks = seq(1:31)) + 
  theme_bw() + 
  scale_fill_viridis_c(option = "A") 