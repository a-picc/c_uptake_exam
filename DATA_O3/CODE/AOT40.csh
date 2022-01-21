#!/bin/csh

setenv INFILE "O3_grw_sns_dayl_2019_veg_agr.nc"
setenv OUFILE "03_AOT40_2019_veg.nc"

# Convert to ppbV, subtract 40 to all value, set values < 0 to NA,
# set all NA to 0 and sum over all timestep to get the AOT40 
# (sum of values over 40 ppbv per hour)
echo "********** Computing AOT40 **********"
cdo  timsum -setmisstoc,0 -setvrange,0,1000 -subc,40 -divc,2 $INFILE $OUFILE

# Converting nc to raste
echo "********** Coversion to asc raster **********"
setenv IODIR ../
setenv INFIL $OUFILE
setenv OUFIL "03_AOT40_ras_2019_veg.asc"
setenv VARPO "o3_conc"

Rscript ../../COD_R/nc2asc.R
