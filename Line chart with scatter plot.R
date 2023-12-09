dat <- data.frame(year = rep(2001:2021, 4),
                  profit = rnorm(84, sd = 50) + c((1:21) * 5, (1:21) * 10, (1:21) * 15, (1:21) * 20), 
                  crop = rep(c("corn", "rice", "soybean", "wheat"), each = 21), 
                  impute = sample(c(TRUE, FALSE), size = 84, replace = T, prob = c(0.1, 0.9)))

ggplot(data = dat, aes(y = profit, x = year, group = crop)) + 
  geom_point(aes(color = interaction(crop, impute, sep = "_"), shape = impute), size = 2.5) +
  geom_line(aes(color = crop), size = 1) +
  xlab("Year") + ylab("Expected Profit") +
  labs(group = "crop") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.title = element_blank(), legend.position = "right") +
  scale_shape_discrete(name = "", labels = c("Corn","Rice","Soybean", "Wheat")) +
  geom_vline(aes(xintercept = 2016), color = "red", linetype = "dashed") +
  geom_hline(aes(yintercept = 0), color = "grey") +
  scale_x_continuous(breaks = seq(2000, 2022, 5)) +
  scale_y_continuous(breaks = seq(-300, 1000, 200)) +
  scale_color_manual(name = "",
                     values = c("corn_FALSE" = "#E69F00", "corn_TRUE" = "black",
                                "rice_FALSE" = "#56B4E9", "rice_TRUE" = "black",
                                "soybean_FALSE" = "#009E73", "soybean_TRUE" = "black",
                                "wheat_FALSE" = "purple", "wheat_TRUE" = "black", 
                                "corn" = "#E69F00", 
                                "rice" = "#56B4E9", 
                                "soybean" = "#009E73", 
                                "wheat" = "purple"),
                     labels = c("Corn", "Rice", "Soybean", "Wheat"), 
                     breaks = c("corn_FALSE", "rice_FALSE", "soybean_FALSE", "wheat_FALSE")) +
  guides(shape = 'none', # remove the shape legend
         color = guide_legend(override.aes = list(
           color = c("#E69F00", "#56B4E9", "#009E73", "purple"),
           size = 1,
           label = c("Corn", "Rice", "Soybean", "Wheat")
         ))) +
  theme_bw()
