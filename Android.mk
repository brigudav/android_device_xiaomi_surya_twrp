#
# Copyright 2018 The Android Open Source Project
# Copyright 2014-2023 The Team Win LLC
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),surya)
include $(call all-subdir-makefiles,$(LOCAL_PATH))

# Hack some props to allow stock ROM flashing
BOARD_RECOVERY_IMAGE_PREPARE := \
    sed -i 's/ro.product.board=.*/ro.product.board=surya/' $(TARGET_RECOVERY_ROOT_OUT)/prop.default;
endif
