library(sf)
library(ggplot2)
library(raster)
library(fasterize)

sh_in<-st_read("../Europe_coastline_shapefile/Europe_coastline_poly.shp")
ras_in<-raster("../DATI_O3/O3_AOT40_proj3035_2019_veg.tif")

ras_out<-raster()
extent(ras_out)<-extent(ras_in)
res(ras_out) <- res(ras_in)
crs(ras_out) <- crs(ras_in)

sh_in<-st_transform(sh_in,crs=crs(ras_in))
sh_in$Id<-1
ras_out<-fasterize(sh_in, ras_out)
ras_out2<-buffer(ras_out, 20000, doEdge=T)
writeRaster(ras_out, "../Europe_coastline_shapefile/Europe_coastline_poly.tif",proj=T)
writeRaster(ras_out2, "../Europe_coastline_shapefile/Europe_coastline_poly_buf.tif",proj=T)
