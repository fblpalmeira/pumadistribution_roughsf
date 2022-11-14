library(sf)
mundi <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
mundi <- st_cast(mundi, "POLYGON")
mundi$fill <- ""
mundi$stroke <- 2
mundi$fillweight <- 0.5

puma <- st_read("p.concolor/puma.shp")
puma <- st_cast(puma, "POLYGON")
puma$fill <- "#E69F00"
puma$stroke <- 1
puma$fillweight <- 1.5

library(roughsf)
mapa<-roughsf::roughsf(list(puma, mundi),
                 title = "Puma concolor: a widely distributed felid", caption = "Data: IUCN Red List | Image credit: dreamstime.com | Visualization by @fblpalmeira",
                 title_font = "45px Pristina", font = "30px Pristina", caption_font = "30px Pristina",
                 roughness = 2, bowing = 2, simplification = 2,
                 width = 1000, height = 800, 
)

library(pagedown)
save_roughsf(mapa, file="puma.png")

library(magick)
library(magrittr)
plot <- image_read("puma.png")
plot2<-image_annotate(plot, "", 
                      color = "gray", size = 12, 
                      location = "10+50", gravity = "southeast")
puma_silhouete <- image_read("https://thumbs.dreamstime.com/b/puma-17-years-puma-concolor-4407514.jpg") 
puma_silhouete2<-image_flop(puma_silhouete)
out<-image_composite(plot2,image_scale(puma_silhouete2,"x175"), gravity="south", offset = "-300+200")

image_browse(out)

image_write(out, "puma2.png")

