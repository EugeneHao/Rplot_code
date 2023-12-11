library(usmap)
library(sf)
library(survey)
data(api)
d <- us_map("counties") %>% dplyr::filter(abbr == "CA")
d$county <- substr(d$county, 1, nchar(d$county) - 7)
d$group <- d$county
# combine some counties together
d$group[d$county %in% c("Del Norte", "Trinity")] <- "Humboldt"
d$group[d$county %in% c("Siskiyou", "Modoc", "Lassen")] <- "Shasta"
d$group[d$county %in% c("Lake")] <- "Mendocino"
d$group[d$county %in% c("Tehama", "Glenn", "Colusa", "Yuba", "Sierra", "Plumas")] <- "Butte"
d$group[d$county %in% c("Sutter", "Nevada")] <- "Placer"
d$group[d$county %in% c("Napa")] <- "Yolo"
d$group[d$county %in% c("Amador")] <- "Sacramento"
d$group[d$county %in% c("Calaveras")] <- "San Joaquin"
d$group[d$county %in% c("Tuolumne", "Alpine", "Mono", "Mariposa")] <- "Stanislaus"
d$group[d$county %in% c("Kings", "Madera")] <- "Fresno"
d$group[d$county %in% c("Inyo")] <- "San Bernardino"
d$group[d$county %in% c("San Benito")] <- "Monterey"


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

USSgroup <- list()
mygroup <- unique(d$group)
for(i in 1:length(mygroup))
{
  element <- d %>% dplyr::filter(group == mygroup[i]) %>% "$"(county) %>% unique()
  if(length(element) == 1)
  {
    USSgroup[[i]] <- USS[element][[1]]
  }
  else
  {
    tmp <- st_union(USS[element[1]][[1]], USS[element[2]][[1]])
    if(length(element) > 2)
      for(j in 3:length(element))
      {
        tmp <- st_union(tmp, USS[element[j]][[1]])
      }
    USSgroup[[i]] <- tmp
  }
}

names(USSgroup) <- mygroup

# school data: 
data(api)
df <- apipop %>% group_by(cname) %>% summarise(num = n()) %>% 
  add_row(., cname = "Alpine", num = 0) %>% 
  arrange(cname) %>% "colnames<-"(c("county", "num"))

df$group <- df$county
df$group[df$county %in% c("Del Norte", "Trinity")] <- "Humboldt"
df$group[df$county %in% c("Siskiyou", "Modoc", "Lassen")] <- "Shasta"
df$group[df$county %in% c("Lake")] <- "Mendocino"
df$group[df$county %in% c("Tehama", "Glenn", "Colusa", "Yuba", "Sierra", "Plumas")] <- "Butte"
df$group[df$county %in% c("Sutter", "Nevada")] <- "Placer"
df$group[df$county %in% c("Napa")] <- "Yolo"
df$group[df$county %in% c("Amador")] <- "Sacramento"
df$group[df$county %in% c("Calaveras")] <- "San Joaquin"
df$group[df$county %in% c("Tuolumne", "Alpine", "Mono", "Mariposa")] <- "Stanislaus"
df$group[df$county %in% c("Kings", "Madera")] <- "Fresno"
df$group[df$county %in% c("Inyo")] <- "San Bernardino"
df$group[df$county %in% c("San Benito")] <- "Monterey"

dfgroup <- df %>% group_by(group) %>% summarise(num = sum(num))

CA  <- st_sfc(USS, crs = usmap_crs()@projargs)
CA  <- st_sf(data.frame(df, geometry = CA))
CA$centroids <- st_centroid(CA$geometry)

CAgroup  <- st_sfc(USSgroup, crs = usmap_crs()@projargs)
CAgroup <- st_sf(data.frame(dfgroup, geometry = CAgroup))
CAgroup$centroids <- st_centroid(CAgroup$geometry)

# show the number of schools in each county group
ggplot() + geom_sf(data = CA) + 
  geom_sf(aes(fill = group, alpha = 0.4), color = "white",  data = CAgroup) + 
  geom_sf_text(aes(label = num, geometry = centroids), colour = "black", size = 4.5, data = CAgroup) +
  # scale_fill_manual(values = c("#67b5e3",  "#ffada2","#1155b6",
  #                              "#ed4747", "#cccccc"), guide = guide_none()) +
  theme_void() + theme(legend.position='none')