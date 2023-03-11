#
# Copyright 2018 The Android Open Source Project
# Copyright 2014-2022 The Team Win LLC
#
# SPDX-License-Identifier: Apache-2.0
#

# Define hardware platform
PRODUCT_PLATFORM := sm6150

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock

# API
PRODUCT_SHIPPING_API_LEVEL := 29

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH) \
	vendor/qcom/opensource/commonsys-intf/display

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Apex libraries
PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libcuuc.so

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
	libion \
	libxml2 \
	vendor.display.config@1.0 \
	vendor.display.config@2.0 \
	libdisplayconfig.qti \
	libandroidicu \
	libdrm

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
	$(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
	$(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so

# Overrides
PRODUCT_BUILD_PROP_OVERRIDES += \
	PRODUCT_NAME=$(PRODUCT_RELEASE_NAME) \
	TARGET_DEVICE=$(PRODUCT_RELEASE_NAME)

PRODUCT_PROPERTY_OVERRIDES += \
	ro.product.device=$(PRODUCT_RELEASE_NAME)
