#
# Copyright (C) 2021 The TWRP Open-Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Define hardware platform
PRODUCT_PLATFORM := sm6150

# Boot control HAL 1.2
#PRODUCT_PACKAGES += \
#    android.hardware.boot@1.2-service

#PRODUCT_COPY_FILES += \
#    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/system/lib64/android.hardware.boot@1.2.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/android.hardware.boot@1.2.so

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd

# API
PRODUCT_SHIPPING_API_LEVEL := 29

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libxml2 \
    android.hardware.boot@1.2-service

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.boot@1.2.so

# Overrides
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=$(PRODUCT_RELEASE_NAME) \
    TARGET_DEVICE=$(PRODUCT_RELEASE_NAME)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.device=$(PRODUCT_RELEASE_NAME)

