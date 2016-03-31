# Quick binary load examples

This repository includes a simple but relatively fast binary data generator
program and example SciDB binary load scripts that illustrate sequential and
parallel binary data load. The load scripts also redimension the example data
into a 2-d array to simulate typical data load workflows.

You can run these tests on your own system. The timings reported here are
examples and were run on a single Amazon EC2 i2.8xlarge instance. As of March,
2016, such an instance includes 32 vCPUs and 8 fairly fast SSD storage devices.
The eight 800MB SSD devices shared by 32 SciDB processes, four processes per
device in the examples shown below.

## Compiling the example data generator

The simple `generator.c` program produces a specified number of records and
writes them in binary format to stdout. Each record consists of 96 bytes as ten
64-bit double-precision numbers and 4 32-bit integers. The program simulates a
data frame or data table like binary output written row-wise.

```
gcc -O3 -o generator generator.c
# run with
./generator N start
```

The program requires two arguments, `N` is the number of 96-byte records to
write to stdout and `start` is the starting record index. The `start` argument
is there to allow multiple copies of the generator process to write the same
output that a single run can write.

## Reference testing

These tests show how fast the generator can run on this system. The first test
shows that the generator can produce 10 million records (960,000,000 bytes) in
about 1/3 second on this system, or about 2.7 GBytes/second.
```
time ./generator 10000000 0 > /dev/null

real    0m0.350s
user    0m0.149s
sys     0m0.201s
```

The next reference test shows that the generator program can write 10 million
records to a single storage device used in about 3.2 seconds on this system
(including data sync to the medium), or about 300 MBytes/second.
```
time ./generator 10000000 0 > /home/scidb/scidb_data/0/0/test.bin

real    0m3.216s
user    0m0.132s
sys     0m1.123s

rm -f /home/scidb/scidb_data/0/0/test.bin
```

Reference performance tests are available in the `reference.sh` script.


## Single process SciDB binary load and redimension

Examine and run the `single_process_example.sh` script to view a typical load
plus redimension script into a two-dimensional SciDB array. The script loads
the data into an array that uses two of the generated integers as coordinate
axes and the remaining 12 doubles and integers as attribute values,
representing a very typical load workflow.

```
./single_process_example.sh
Query was executed successfully

real    0m26.960s
user    0m1.363s
sys     0m1.767s
```
The example loads and redimensions at a rate of about 36 MBytes/second on this
system.


## Parallel SciDB binary load

The Amazon EC2 single i2.8xlarge Amazon EC2 instance includes eight 800MB SSD
storage devices. We configured SciDB with 32 instaces (SciDB processes) using
four instances per storage device.

The `multi_process_example.sh`  script distributes the data generation among 32
generators, one for each SciDB instance, and loads their output in parallel.
```
./multi_process_example.sh 
Query was executed successfully

real    0m7.741s
user    0m0.270s
sys     0m0.640s
```
Parallel binary load performance improves on this sytem to about 124 MBytes/second.
