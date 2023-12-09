set.seed(1)
df=data.frame(year=rep(2009:2013,each=4),
              quarter=rep(c("Q1","Q2","Q3","Q4"),5),
              sales=40:59+rnorm(20,sd=5))

ggplot(data = df, aes(x = interaction(year, quarter, lex.order = TRUE), 
                      y = sales, group = 1)) +
  geom_line(colour = "blue") +
  annotate(geom = "text", x = seq_len(nrow(df)), y = 34, label = df$quarter, size = 4) +
  annotate(geom = "text", x = 2.5 + 4 * (0:4), y = 32, label = unique(df$year), size = 6) +
  coord_cartesian(ylim = c(35, 65), expand = FALSE, clip = "off") +
  theme_bw() +
  theme(plot.margin = unit(c(1, 1, 4, 1), "lines"),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())
