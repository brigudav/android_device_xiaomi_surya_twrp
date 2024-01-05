#!/bin/bash
cd ~
cd ~/workspace/bootable/recovery
cd ~/bootable/recovery
patch -p1 < ../../device/xiaomi/surya/patches/0001-revert-save-settings-file-in-persist.patch
cd ../..
