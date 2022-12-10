#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/daylight/jagar/device.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_jagar
PRODUCT_DEVICE := jagar
PRODUCT_MANUFACTURER := Daylight
PRODUCT_BRAND := Daylight
PRODUCT_MODEL := DC-1

PRODUCT_GMS_CLIENTID_BASE := android-hyst

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildFingerprint=Daylight/Daylight10_Ultra/Daylight10_Ultra:14/20240427/UP1v:user/release-keys \
    DeviceProduct=jagar
