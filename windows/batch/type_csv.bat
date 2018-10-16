@echo off
for /f "tokens=1-4 delims=," %%G IN (inp.csv) do (
echo c1= %%G c2= %%H
echo c3= %%I
)

::  File: inp.csv
::  s1,s2,s3
::  p1,p2,p3
