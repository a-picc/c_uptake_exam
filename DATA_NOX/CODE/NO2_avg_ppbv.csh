#!/bin/csh

setenv INF1 "NO2_01_03.nc"
setenv INF2 "NO2_04_06.nc"
setenv INF3 "NO2_07_09.nc"
setenv INF4 "NO2_10_12.nc"

setenv OUF1 "NO2_year_avg_ppb.nc"

setenv CONV 1.92

echo "Sum file " $INF1
cdo timsum $INF1 temp1
echo "Sum file " $INF2
cdo timsum $INF2 temp2
echo "Sum file " $INF3
cdo timsum $INF3 temp3
echo "Sum file " $INF4
cdo timsum $INF4 temp4

echo "Ens sum of time sums"
cdo enssum temp[1-4] temp5

rm temp1 temp2 temp3 temp4

echo "Annual average and conversion to ppbv. OUT: " $OUF1
cdo divc,8760 -divc,$CONV temp5 $OUF1

rm temp5
