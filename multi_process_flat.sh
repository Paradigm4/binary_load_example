#!/bin/bash
# 960,000,000 bytes (10 million records) divided across 32 instances
# for 312500 records per instance.

# Assume 32 scidb instances with storage directories
# /dev/shm/0/j

# create pipes and start generators
j=0
k=0
while test $j -lt 32;do
  rm -rf /dev/shm/0/${j}/p
  mkfifo /dev/shm/0/${j}/p
  ./generator 312500 $k > /dev/shm/0/${j}/p &
  j=$(($j + 1))
  k=$(($k + 312500))
done
sleep 1


time iquery -naq "store(input(
<d1:double,
 d2:double,
 d3:double,
 d4:double,
 d5:double,
 d6:double,
 d7:double,
 d8:double,
 d9:double,
 d10:double,
 i1:int32,
 i2:int32,
 i3:int32,
 i4:int32>
 [i=0:*,1000000,0],
 'p', -1,
 '(double, double, double, double, double, double, double, double, double, double, int32, int32, int32, int32)'),
flat)"

wait
