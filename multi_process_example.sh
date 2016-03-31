#!/bin/bash
# 960,000,000 bytes (10 million records) divided across 32 instances
# for 312500 records per instance.

# Assume 32 scidb instances with storage directories
# /home/scidb/scidb_data/0/j

# create pipes and start generators
j=0
k=0
while test $j -lt 32;do
  rm -rf /home/scidb/scidb_data/0/${j}/p
  mkfifo /home/scidb/scidb_data/0/${j}/p
  ./generator 312500 $k > /home/scidb/scidb_data/0/${j}/p &
  j=$(($j + 1))
  k=$(($k + 312500))
done


time iquery -naq "store(redimension(input(
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
 [i=0:*,100000,0],
 'p', -1,
 '(double, double, double, double, double, double, double, double, double, double, int32, int32, int32, int32)'),
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
 i3:int32,
 i4:int32>
[i1=0:*,10,0, i2=0:*,100000,0]), x)"

wait
