#!/bin/bash
cd $1
cd ./bootable/recovery
for f in ../../device/xiaomi/surya/patches/*.patch
do
  patch -p1 < $f
done
cd ../..
