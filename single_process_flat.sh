#!/bin/bash
rm -f /tmp/p
mkfifo /tmp/p
# 960,000,000 bytes
./generator 10000000 0 > /tmp/p &

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
 [i=0:*,100000,0],
 '/tmp/p', -2,
 '(double, double, double, double, double, double, double, double, double, double, int32, int32, int32, int32)'),
flat)"

wait
rm -f /tmp/p
