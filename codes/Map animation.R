invisible(capture.output(
  lapply(c("sf", "usmap", "gganimate", "gifski"), require, character.only = TRUE)
))

rawd <- us_map("counties") %>% dplyr::filter(abbr == "IA")
rawd$county <- substr(rawd$county, 1, nchar(rawd$county) - 7)
rawd$group <- rawd$county
d <- rawd %>% arrange(group)


database <- data.frame(county = rep(d$county %>% unique(), 20),
                       year = rep(2001:2020, each = 99), 
                       Value = round(rbeta(99 * 20, 2, 20) * 100, 1)) %>%
  mutate(level = cut(Value, breaks = c(0, 3, 5, 7, 9, 100), labels = c("VeryLow", "Low", "Medium", "High", "VeryHigh")))

colorvalues <- c("VeryHigh" = "#ed4747", "High" = "#ffada2", "Medium" = "#cccccc", "Low" = "#67b5e3", "VeryLow" = "#1155b6")


database <- database %>% arrange(year, county)

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

spdata  <- st_sfc(USS, crs = usmap_crs()@projargs)
tmp <- data.frame()
for(yr in 2001:2020)
{
  tmp <- rbind(tmp, st_sf(data.frame(database %>% dplyr::filter(year == yr), geometry = spdata)))
}
tmp$centroids <- st_centroid(tmp$geometry)

tmp <- cbind(tmp, do.call(rbind, st_geometry(tmp$centroids)) %>% 
               as_tibble() %>% setNames(c("lon","lat")))

originplot = ggplot() + 
  geom_sf(aes(fill = level, alpha = 0.4), color = "white",  data = tmp) +
  scale_fill_manual(values = colorvalues, guide = guide_none()) + 
  theme_void() + theme(legend.position='none', plot.title = element_text(hjust = 0.5))

animateplot = originplot +  
  geom_text(aes(y = lat, x = lon, label = Value), 
            colour = "black", size = 4.5, data = tmp) +
  geom_text(data = tmp, 
            aes(x = median(lon), y = min(lat) - abs(max(lat) - min(lat))/4, 
                label = paste("UR In", "Iowa", "In", year)),
            colour = "black", size = 5) +
  transition_states(states = year) 

animate(animateplot, renderer = gifski_renderer(), fps = 5, duration = 10)