# android_device_xiaomi_surya_twrp
For building TWRP for POCO X3 / X3 NFC (codenamed "karna / surya")

TWRP device tree for POCO X3 (karna/surya)

## Features

Works:

- [X] ADB
- [ ] Decryption of /data
- [X] Screen brightness settings
- [X] Vibration support
- [X] Correct screenshot
- [X] Correct date/battery level/temperature
- [X] MTP
- [X] Flashing (opengapps, roms, images and so on)
- [X] Backup/Restore to internal/microSD
- [X] Backup/Restore to/from adb (https://gerrit.omnirom.org/#/c/15943/)
- [X] USB OTG
- [X] Fasbootd
- [X] Sideload (adb sideload update.zip)
- [X] Reboot to bootloader/recovery/system/fasbootd
- [X] F2FS/EXT4 Support, exFAT/NTFS where supported

## Compile

First checkout minimal twrp with aosp tree:

```
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/surya" name="brigudav/android_device_xiaomi_surya_twrp" remote="github" revision="android-11" />
```

Finally execute these:

```
. build/envsetup.sh
lunch twrp_surya-eng
mka recoveryimage ALLOW_MISSING_DEPENDENCIES=true # Only if you use minimal twrp tree.
```

To test it:

```
fastboot boot out/target/product/surya/recovery.img
```

## Other Sources

Using precompiled stock kernel.
