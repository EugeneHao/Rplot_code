d <- Sleuth3::case1402 %>%
  pivot_longer(Forrest:William, names_to = "variety", values_to = "yield")

ggplot(d, aes(x = O3, y = yield, group = O3)) + geom_boxplot() +
  geom_point() +
  geom_smooth(method = lm, aes(group=1)) +
  scale_x_continuous(breaks = c(0, unique(d$O3))) +
  ggtitle("Yield vs O3") + xlab("O3") + ylab("") +
  theme(axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
