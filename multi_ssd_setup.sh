#!/bin/bash
# 960,000,000 bytes (10 million records) divided across 32 processes
# for 312500 records per process.

# Set up links to 8 ssd devices
ln -sf /mnt/b /tmp/0
ln -sf /mnt/b /tmp/1
ln -sf /mnt/b /tmp/2
ln -sf /mnt/b /tmp/3
ln -sf /mnt/c /tmp/4
ln -sf /mnt/c /tmp/5
ln -sf /mnt/c /tmp/6
ln -sf /mnt/c /tmp/7
ln -sf /mnt/d /tmp/8
ln -sf /mnt/d /tmp/9
ln -sf /mnt/d /tmp/10
ln -sf /mnt/d /tmp/11
ln -sf /mnt/e /tmp/12
ln -sf /mnt/e /tmp/13
ln -sf /mnt/e /tmp/14
ln -sf /mnt/e /tmp/15
ln -sf /mnt/f /tmp/16
ln -sf /mnt/f /tmp/17
ln -sf /mnt/f /tmp/18
ln -sf /mnt/f /tmp/19
ln -sf /mnt/g /tmp/20
ln -sf /mnt/g /tmp/21
ln -sf /mnt/g /tmp/22
ln -sf /mnt/g /tmp/23
ln -sf /mnt/h /tmp/24
ln -sf /mnt/h /tmp/25
ln -sf /mnt/h /tmp/26
ln -sf /mnt/h /tmp/27
ln -sf /mnt/i /tmp/28
ln -sf /mnt/i /tmp/29
ln -sf /mnt/i /tmp/30
ln -sf /mnt/i /tmp/31

rm -rf /mnt/b/*
rm -rf /mnt/c/*
rm -rf /mnt/d/*
rm -rf /mnt/e/*
rm -rf /mnt/f/*
rm -rf /mnt/g/*
rm -rf /mnt/h/*
rm -rf /mnt/i/*
