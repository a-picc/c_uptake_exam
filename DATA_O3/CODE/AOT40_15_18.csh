#!/bin/csh

setenv aa 2015
while($aa <= 2018)

  setenv INFILE ENSa.${aa}.O3.aot40.nc
  setenv OUFILE 03_AOT40_${aa}.nc

  # Convert to ppbV
  echo "********** Computing AOT40 **********"
  cdo  divc,2 $INFILE $OUFILE

  # Converting nc to raste
  echo "********** Coversion to asc raster **********"
  setenv IODIR ../
  setenv INFIL $OUFILE
  setenv OUFIL 03_AOT40_ras_${aa}.asc
  setenv VARPO ""

  Rscript ../../COD_R/nc2asc.R

  setenv aa $aa+1
end
