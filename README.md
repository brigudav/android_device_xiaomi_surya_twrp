## Device Tree for building TWRP for POCO X3 NFC (karna/surya)

## Features

<details><summary>Works: - Click to open</summary>
<p>

- [X] ADB
- [X] Decryption of /data (MIUI Android 12/Custom rom Android 12-13 FBEv1)
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

</p>
</details>

## Compile

First checkout minimal twrp with aosp tree:

```
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/surya" name="brigudav/android_device_xiaomi_surya_twrp" remote="github" revision="android-12.1" />
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

### Copyright
 ```
  /*
  *  Copyright (C) 2013-23 The TWRP
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  */
  ```
