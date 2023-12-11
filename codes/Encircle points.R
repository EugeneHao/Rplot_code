ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point() + 
  geom_encircle(data = subset(iris, Sepal.Width < 2.5 & Sepal.Length > 5.5), s_shape = 0) +  # encircle points 
  geom_point(data = subset(iris, Sepal.Width < 2.5 & Sepal.Length > 5.5),   # mark as blue 
             colour = "steelblue", size = 2.5)