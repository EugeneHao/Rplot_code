require(dabestr)

mydata <- iris[iris$Species %in% c("setosa", "versicolor"), ] %>% 
  mutate(Class = ifelse(Sepal.Length > 5.5, "Long", "Short"))

mytest <- dabest(mydata, Species, Petal.Width,    # Compare Petal.Width for Species
                 idx = c("setosa", "versicolor"), # setosa is the control group 
                 paired = FALSE) 

mymean_diff <- mean_diff(mytest)

plot(mymean_diff, color.column = Class)