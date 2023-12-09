ggplot(mtcars, aes(wt, mpg)) +  
  geom_point() +  
  labs(x = paste0("<span style='font-size: 11pt'>This is the axis of</span><br>
                  <span style='font-size: 7pt'>wt</span>"), 
       y = paste0("<span style='font-size: 11pt'>This is the axis of</span><br>
                  <span style='font-size: 7pt'>mpg</span>")) +  
  theme(axis.title.x = ggtext::element_markdown(),
        axis.title.y = ggtext::element_markdown())
