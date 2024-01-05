#!/bin/bash
CUR_DIR=$PWD
cd ~/${GITHUB_WORKSPACE}/workspace/workspace/bootable/recovery
patch -p1 < ../../device/xiaomi/surya/patches/0001-revert-save-settings-file-in-persist.patch
cd ../..
