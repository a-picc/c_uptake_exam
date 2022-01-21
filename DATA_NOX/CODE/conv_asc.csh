#!/bin/csh

#convert nc file to asc with sdr
setenv IODIR "."
setenv INFIL "NOX_year_mean.nc"
setenv OUFIL "NOX_yrlm.asc"
setenv VARPO "no_conc"

Rscript ../../COD_R/nc2asc.R

