#!/bin/csh

setenv IFIL1 "NO_year_avg_ppb.nc"
setenv IFIL2 "NO2_year_avg_ppb.nc"

setenv OFIL1 "NOX_year_mean.nc"

setenv CONV 1.92

cdo mulc,$CONV -add $IFIL1 $IFIL2 $OFIL1
