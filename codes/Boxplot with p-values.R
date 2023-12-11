ggplot(iris, aes(Species, Sepal.Length)) + 
  geom_boxplot() +
  ggsignif::geom_signif(comparisons = list(c(1, 2)), # group 1 vs group 2
                        y_position = 8, 
                        tip_length = 0) + 
  ggsignif::geom_signif(comparisons = list(c(1, 3)), 
                        y_position = 8.6,
                        tip_length = 0) + 
  ggsignif::geom_signif(comparisons = list(c(2, 3)), 
                        y_position = 8.3, 
                        tip_length = 0)