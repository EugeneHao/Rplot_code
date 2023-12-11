library(usmap)
library(sf)

d <- us_map("counties") %>% dplyr::filter(abbr == "IA")
d$county <- substr(d$county, 1, nchar(d$county) - 7)   # remove string " county"
d$group <- d$county
d <- d %>% arrange(group)

database <- data.frame(county = d$county %>% unique(), 
                       erosion = rbeta(99, 2, 4) * 14) %>% 
  mutate(erolv = cut(erosion, breaks = c(0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5:13, 100), 
                     labels = c(paste0("C", 1:19))))

# color code
colorvalues <- c("C1" = "#83858c", "C2" = "#6d7985", "C3" = "#62807c", "C4" = "#4b734c", 
                 "C5" = "#4a734c", "C6" = "#667c3e", "C7" = "#748036", "C8" = "#5f7824", 
                 "C9" = "#978e24", "C10"= "#977f17", "C11"= "#90651b", "C12"= "#8a4c1b", 
                 "C13"= "#82341a", "C14"= "#781e1a", "C15"= "#571528", "C16"= "#3a132b", 
                 "C17"= "#2e1739", "C18"= "#1a0b1d", "C19"= "#110a16")
# polygon 
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

ggplot() + geom_sf(data = tmp) +
  geom_sf(aes(fill = erolv), color = "white",  data = tmp) +
  geom_sf_text(aes(label = county, geometry = centroids), colour = "black", size = 3.5, data = tmp) +
  scale_fill_manual(values = colorvalues, 
                    labels = c("[0, 0.5)", "[0.5, 1)", "[1, 1.5)", "[1.5, 2)", "[2, 2.5)", 
                               "[2.5, 3)", "[3, 3.5)", "[3.5, 4)", "[4, 4.5)", "[4.5, 5)",
                               "[5, 6)", "[6,7)", "[7, 8)", "[8, 9)", "[9, 10)", "[10, 11)", 
                               "[11, 12)", "[12, 13)", ">= 13")) +    # change legend names and colors 
  ggtitle("Iowa") + 
  guides(fill = guide_legend(title = NULL)) +   # remove legend title
  theme_void() + theme(plot.title = element_text(hjust = 0.5))