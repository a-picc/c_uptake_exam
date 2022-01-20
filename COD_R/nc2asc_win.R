library(ncdf4)
library(raster)

infile<-"../DATI_SO2/out_avg.nc"
outfile<-"../DATI_SO2/out_sdr.asc"
sdr<-"+proj=longlat +datum=WGS84 +no_defs"
var_p<-"so2_conc"

in_nc<-nc_open(infile)
POL<-ncvar_get(in_nc,var_p)

ras<-raster(t(POL),ymn=30,ymx=70,xmn=-25,xmx=45,crs=sdr)
writeRaster(ras, outfile,prj=T)
