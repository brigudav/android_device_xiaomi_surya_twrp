#!/bin/bash
cd ./bootable/recovery
patch -p1 < ../../device/Tecno/Camon18P/patches/0001-revert-save-settings-file-in-persist.patch
cd ../..
