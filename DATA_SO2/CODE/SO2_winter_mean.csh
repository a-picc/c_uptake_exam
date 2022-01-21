#!/bin/csh

#merge the two nc files into one
cdo -mergetime SO2_gen_mar.nc SO2_oct_dec.nc outall.nc
#compute SO2 winter mean
cdo timmean outall.nc out_avg.nc

#convert nc file to asc with sdr
setenv IODIR ..
setenv INFIL "out_avg.nc"
setenv OUFIL "out_sdr.asc"
setenv VARPO "so2_conc"

Rscript ../../COD_R/nc2asc.R
