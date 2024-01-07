#!/bin/bash
cd ./bootable/recovery
patch -p1 < ../../device/xiaomi/surya/patches/0001-revert-save-settings-file-in-persist.patch
patch -p1 < ../../device/xiaomi/surya/patches/0002-set-data-recovery.patch
cd ../..
