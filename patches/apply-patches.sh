#!/bin/bash -e
cd bootable/recovery
patch -p1 --forward < ../../device/xiaomi/surya/patches/0001-revert-save-settings-file-in-persist.patch
cd -
