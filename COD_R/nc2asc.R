library(ncdf4)
library(raster)

iodir<-Sys.getenv("IODIR")
setwd(iodir)

infile<-Sys.getenv("INFIL")
outfile<-Sys.getenv("OUFIL")
sdr<-"+proj=longlat +datum=WGS84 +no_defs"
var_p<-Sys.getenv("VARPO")

in_nc<-nc_open(infile)
POL<-ncvar_get(in_nc,var_p)

ras<-raster(t(POL),ymn=30,ymx=70,xmn=-25,xmx=45,crs=sdr)
writeRaster(ras, outfile,prj=T)
