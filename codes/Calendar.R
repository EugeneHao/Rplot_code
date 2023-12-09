require(sugrrants)
require(lubridate)

data.frame(date = lubridate::ymd(strtrim(seq(ISOdate(2017,10,1), ISOdate(2018,2,28), "DSTday"),10)), 
           # or as.Date("2017-10-1") + 0:150
           n = sample(1:100, size = 151, replace = T)) %>% 
  sugrrants::frame_calendar(x = 1, y = 1, date = date) %>% 
  ggplot(aes(x = .x, y = .y)) +
  ggtitle("Daily sold units") +
  theme_bw() + 
  theme(legend.position = "bottom", 
        plot.title = element_text(hjust = 0.5)) +
  geom_tile(aes(x = .x+(1/13)/2, y = .y+(1/9)/2, fill = n), colour = "grey50") +
  scale_fill_distiller(name = "", palette = "RdYlBu") -> p2.sale 
  sugrrants::prettify(p2.sale, label = c("label", "text", "text2")) # label: month and year; text: weekday at the bottom; text2: day of month
