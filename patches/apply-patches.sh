#!/bin/bash
cd ./bootable/recovery
patch -p1 < ../../device/xiaomi/surya/patches/0001-set-data-recovery.patch
cd ../..