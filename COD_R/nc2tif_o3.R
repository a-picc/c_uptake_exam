library(ncdf4)
library(raster)

infile<-"../DATI_O3/ENSa.2018.O3.aot40.nc"
outfile<-"../DATI_O3/O3_AOT40_proj3035_2018.tif"
sdr<-"+proj=longlat +datum=WGS84 +no_defs"
var_p<-"AOT40"

in_nc<-nc_open(infile)
POL<-ncvar_get(in_nc,var_p)

ras<-flip(raster(t(POL),ymn=30,ymx=70,xmn=-25,xmx=45,crs=sdr),"y")
plot(ras)
pr_ras<-projectRaster(ras,crs="+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs ",res=10000)
plot(pr_ras)
pr_ras<-pr_ras/2 #TO ppm
writeRaster(pr_ras, outfile,prj=T,overwrite=TRUE)
