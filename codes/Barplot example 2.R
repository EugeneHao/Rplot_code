getrank <- function(data)
{
  group <- nrow(data)/4
  rankvalue <- NULL
  for(i in 1:group)
  {
    rankvalue <- c(rankvalue, rank(ifelse(data$stat[i*4] %in% c("n_over", "risk"), 1, -1) *      
                                     data$value[((i-1)*4+1):(i*4)], ties.method = "min"))
  }
  data$rank <- as.character(rankvalue)
  return(data)
}

data.frame(curve = rep(1:4, each = 4), 
           design = rep(paste("D", 1:4, sep = ""), 4), 
           correct = runif(16, max = 100), 
           OBD = runif(16, max = 100), 
           noOBD = runif(16, max = 100), 
           risk = runif(16, max = 100)) %>% 
  gather(key = "stat", value = "value", -curve, -design) %>%
  getrank() %>%
  mutate_if(is.numeric, ~round(., 1)) %>%
  mutate(ifbest = as.character(rank == "1")) %>%
  ggplot(aes(x = curve, y = value, fill = design, pattern = ifbest)) +
  geom_bar_pattern(
                   width=0.75, position = position_dodge2(width=0.7, preserve = "single"),
                   color = "black",
                   stat = "identity",
                   pattern_fill = NA,
                  pattern_density = 1.0,
                  pattern_key_scale_factor = 0.5) +
  scale_fill_manual(values = c("#EC8F76","#37BAEB", "#A2E265","#E8EC76" ),
                    labels = c("D1", "D2", "D3", "D4")) +
  scale_pattern_manual(values = c("TRUE" = "stripe", "FALSE" = "none"), guide = "none") +
   guides(fill = guide_legend(override.aes = list(pattern = "none"),
                             title = NULL)) +
  facet_wrap(~factor(stat, levels = c("OBD", "noOBD", "correct", "risk")),
             nrow = 2, scales = "free") +
  geom_text(aes(label=value), position=position_dodge(width=0.7), vjust=-0.25, size = 3) +
  theme_bw()
