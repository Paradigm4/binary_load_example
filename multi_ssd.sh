#!/bin/bash
# 960,000,000 bytes (10 million records) divided across 32 processes
# for 312500 records per process.
#
# Run ./multi_ssd_setup.sh first!

j=0
k=0
while test $j -lt 32;do
  rm -rf /dev/shm/out.${j}
  ./generator 312500 $k > /tmp/${j}/out.${j} &
  j=$(($j + 1))
  k=$(($k + 312500))
done
wait
