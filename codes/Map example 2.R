library(usmap)
library(sf)
huc8 <- readRDS("data/huc8.rds")

d <- us_map("counties") %>% dplyr::filter(abbr == "IA")
d$county <- substr(d$county, 1, nchar(d$county) - 7)   # remove string " county"
d$group <- d$county
d <- d %>% arrange(group)

set.seed(123)
database <- data.frame(county = d$county %>% unique(), 
                       countyid = 1:99, 
                       num = 0) 

for(i in 1:99)
{
  database$num[i] <- sample(c(0, round(100 * rbeta(1, 2, 10))), 1)
}

database <- database %>% 
  mutate(numrange = cut(num, breaks = c(-1, 1, 3, 10, 20, 300), 
                        labels = c(paste0("C", 1:5))))

colorvalues <- c("C1" = "#FFFFFF", "C2" = "#e7f9e0", "C3" = "#d0f3c1", 
                 "C4" = "#a1e784", "C5" = "#5bd629")

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


huc8$centroids <- st_centroid(huc8$geometry)

ggplot() + geom_sf(data = tmp, aes(fill = numrange), color = "grey") +
  geom_sf(data = huc8, color = "#1660CF", fill = "#FFFFFF00") + 
  geom_sf_text(aes(label = SUBBASIN, geometry = centroids), colour = "#0563F0", 
               size = 2.5, data = huc8, fontface = "bold") + 
  scale_fill_manual(values = colorvalues, 
                    labels = c("0", "1 ~ 3", "4 ~ 10", "11 ~ 20", ">20")) + 
  guides(fill = guide_legend(title = "Count")) + 
  theme_void() + 
  theme(plot.title = element_text(hjust = 0.5), legend.position="bottom")