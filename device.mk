# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Device path
DEVICE_PATH := device/sony/dora

DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Device Specific Permissions
PRODUCT_COPY_FILES := \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/system/etc/BCM4359C0.hcd:system/etc/firmware/BCM4359C0.hcd \
    $(DEVICE_PATH)/rootdir/system/etc/wifi/bcmdhd.cal:system/etc/wifi/bcmdhd.cal \
    $(DEVICE_PATH)/rootdir/system/etc/sensors/sensor_def_qcomdev.conf:system/etc/sensors/sensor_def_qcomdev.conf

# Thermal Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/etc/thermanager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/thermanager.xml

# Camera Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/system/etc/camera/camera_config.xml:system/etc/camera/camera_config.xml \
    $(DEVICE_PATH)/rootdir/system/etc/camera/imx214_chromatix.xml:system/etc/camera/imx214_chromatix.xml \
    $(DEVICE_PATH)/rootdir/system/etc/camera/imx300_chromatix.xml:system/etc/camera/imx300_chromatix.xml

# Audio configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/etc/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf \
    $(DEVICE_PATH)/rootdir/vendor/etc/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml

# Audio calibration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/system/etc/acdbdata/Bluetooth_cal.acdb:system/etc/acdbdata/Bluetooth_cal.acdb \
    $(DEVICE_PATH)/rootdir/system/etc/acdbdata/General_cal.acdb:system/etc/acdbdata/General_cal.acdb \
    $(DEVICE_PATH)/rootdir/system/etc/acdbdata/Global_cal.acdb:system/etc/acdbdata/Global_cal.acdb \
    $(DEVICE_PATH)/rootdir/system/etc/acdbdata/Handset_cal.acdb:system/etc/acdbdata/Handset_cal.acdb \
    $(DEVICE_PATH)/rootdir/system/etc/acdbdata/Hdmi_cal.acdb:system/etc/acdbdata/Hdmi_cal.acdb \
    $(DEVICE_PATH)/rootdir/system/etc/acdbdata/Headset_cal.acdb:system/etc/acdbdata/Headset_cal.acdb \
    $(DEVICE_PATH)/rootdir/system/etc/acdbdata/Speaker_cal.acdb:system/etc/acdbdata/Speaker_cal.acdb

# NFC Configuration
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/vendor/etc/libnfc-brcm.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-brcm.conf \
    $(DEVICE_PATH)/rootdir/vendor/etc/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf

# Device Init
PRODUCT_PACKAGES += \
    init.recovery.dora \
    init.dora \
    ueventd.dora

# Lights
PRODUCT_PACKAGES += \
    lights.dora

# Simple PowerHAL
PRODUCT_PACKAGES += \
    power.dora

# Fingerprint HAL
PRODUCT_PACKAGES += \
    fingerprint.dora

# NFC config
PRODUCT_PACKAGES += \
    nfc_nci.dora

# Telephony Packages (AOSP)
PRODUCT_PACKAGES += \
    InCallUI \
    Stk

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

PRODUCT_PROPERTY_OVERRIDES := \
    ro.sf.lcd_density=480 \
    ro.usb.pid_suffix=1E1

# Inherit from those products. Most specific first.
$(call inherit-product, device/sony/tone/platform.mk)

# copy wlan firmware
$(call inherit-product-if-exists, vendor/broadcom/wlan/bcmdhd/firmware/bcm4359/device-bcm-vendor.mk)

# copy NFC firmware
$(call inherit-product-if-exists, vendor/nxp/nxp-vendor.mk)

# include board vendor blobs
$(call inherit-product-if-exists, vendor/sony/tone-common/tone-partial.mk)

# include optional vendor configuration
$(call inherit-product-if-exists, vendor/qcom/proprietary/common/build/qcom-packages.mk)
