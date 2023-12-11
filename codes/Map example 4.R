library(usmap)
library(sf)
library(ggpattern)
d <- us_map("counties") %>% dplyr::filter(abbr == "IA")
d$county <- substr(d$county, 1, nchar(d$county) - 7)
d$group <- d$county
d <- d %>% arrange(group)
set.seed(12345)
database <- data.frame(county = d$county %>% unique(), 
                       Mul = rnorm(99, mean = 0, sd = 2))
database$Mul[database$Mul > 6] <- 6
database$Mul[database$Mul < -6] <- -6

database <- database %>%
  mutate(MulLv = cut(Mul, breaks = c(-6, -3, -2, -1.5, -1, -0.5, -0.1, 0.1, 0.5, 1, 1.5, 2, 3, 6),
                     labels = c(paste0("B", 6:1), "N", paste0("R", 1:6))))

colorvalues <- c(c("B6" = "#0000ff", "B5" = "#3737f1", "B4" = "#4a4aec", 
                   "B3" = "#5c5ce7", "B2" = "#8181de", "B1" = "#a6a6d5",
                   "N" = "#FFFFFF"),
                 c("R6" = "#ff0000", "R5" = "#f13737", "R4" = "#ec4a4a", 
                   "R3" = "#e75c5c", "R2" = "#de8181", "R1" = "#d5a6a6")[6:1])

USS <- lapply(split(d, d$county), function(x) {
  if(length(table(x$piece)) == 1)
  {
    st_polygon(list(cbind(x$x, x$y)))
  }
  else
  {
    st_multipolygon(list(lapply(split(x, x$piece), function(y) cbind(y$x, y$y))))
  }
})

tmp  <- st_sfc(USS, crs = usmap_crs()@projargs)
tmp  <- st_sf(data.frame(database, geometry = tmp))
tmp$centroids <- st_centroid(tmp$geometry)

g4 <- ggplot() + geom_sf(data = tmp) +
  geom_sf_pattern(aes(fill = MulLv, pattern = MulLv), color = "black",  data = tmp, 
                  pattern_key_scale_factor = 0.5) +
  geom_sf_text(aes(label = county, geometry = centroids), colour = "black", size = 3, data = tmp) +
  scale_fill_manual(values = colorvalues,
                    labels = c(" >= 3", "[2, 3)", "[1.5, 2)", "[1, 1.5)", "[0.5, 1)", "[0.1, 0.5)", "[-0.1, 0.1)",
                               "[-0.5, -0.1)", "[-1, -0.5)", "[-1.5, -1)", "[-2, -1.5)", "[-3, -2)", "<= -3")[13:1]) +
  scale_pattern_manual(values = c(rep("stripe", 6), rep("none", 7)), guide = "none") +
  guides(fill = guide_legend(title = NULL, override.aes = list(pattern = c(rep("stripe", 6), rep("none", 7))))) +
  theme_void() + theme(plot.title = element_text(hjust = 0.5), legend.text = element_text(size=10))

g4