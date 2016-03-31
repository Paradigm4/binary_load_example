#!/bin/bash
#
# Test just the generator performance.
#
# Test 1: How fast can the generator produce records, without any storage artifacts?
# 960,000,000 bytes
time ./generator 10000000 > /dev/null

#
# Test 2: How fast can the generator write to a single storage device on this system?
time ./generator 10000000 > /home/scidb/scidb_data/0/0/test.bin
rm -f /home/scidb/scidb_data/0/0/test.bin
