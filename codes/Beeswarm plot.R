require(ggbeeswarm)

ggplot(iris, aes(Species, Sepal.Length, colour = Species)) +
  geom_violin(width = 0.5) +
  geom_beeswarm() +
  theme_classic() +
  scale_color_brewer(palette = "Set1")
