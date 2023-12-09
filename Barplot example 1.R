dat2 <- data.frame(
  categ = rep(c("Roads", "Canals", "Early railways", "Railways"), each = 3) %>% forcats::fct_inorder(), 
  group =  rep(c("Maximum", "Mean", "Minimum"), 4), 
  fill = as.character(c(1,1,1,1,1,1, 2, 1, 3, 1,1,1)), 
  pattern = c(rep("N", 6), "D", rep("N", 5)), 
  record = c(NA, 5, NA, 11.5, 3.77, 1.4, 14.3, 6, 2.3, NA, 1.4, NA)
)


dat2 %>% dplyr::filter(is.na(record) == FALSE) %>% 
ggplot() + 
  geom_bar_pattern(aes(x = categ, y = record, fill = fill, group = group, pattern = pattern), 
                   width=0.4, position = position_dodge2(width=0.5, preserve = "single"), 
                   color = "black", 
                   stat = "identity", 
                  pattern_density = 1.0,
                  pattern_fill = 'grey',
                  pattern_key_scale_factor = 0.5) + 
  scale_fill_manual(values = c("#1B4264","#D3CEC7","#5A6065"), 
                    labels = c("Mean", "Maximum", "Minimum")) +
  scale_pattern_manual(values = c(D = "stripe", N = "none"), guide = "none") + 
  guides(fill = guide_legend(override.aes = list(pattern = "none"), 
                             title = NULL)) + 
  scale_y_continuous(breaks = c(0, 2, 4, 6, 8, 10, 12, 14)) + 
  labs(x = NULL, y = "Pence") + 
  theme_bw() + 
  theme(text = element_text(size = 15), axis.text.y = element_text(angle = 30, hjust = 1)) 
