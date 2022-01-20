#!/bin/csh

#Get NO yearly mean in ppbV
echo "******** Computing NO yearly mean ********"
./NO_avg_ppbv.csh

#Get NO2 yearly mean in ppbV
echo "******** Computing NO2 yearly mean ********"
./NO2_avg_ppbv.csh

#Get NOX yearly mean in ug/m3
echo "******** Computing NOX yearly mean ********"
./NOX_avg.csh

#Convert nc to raster
echo "******** Creating NOX raster file ********"
./conv_asc.csh
