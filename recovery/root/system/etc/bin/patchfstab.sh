#!/system/bin/sh
#
# This script is needed to support wrappedkey and fbe v2
# Version: 1.3
# Date : 2023/03/11
# Author : brigudav
#

reclog=/tmp/recovery.log
tmpv=/tmp/vendor_fstab
fstabd=$tmpv/etc/fstab.default
fstabq=$tmpv/etc/fstab.qcom
fstabr=/system/etc/recovery.fstab

send_log() {
	echo "I:$1" >> $reclog
}

finish() {
	sleep 1
	umount $tmpv || true
	rmdir $tmpv
	exit 1
}

patch_fstab() {
	mkdir -p $tmpv
	mount -o ro -t auto /dev/block/mapper/vendor $tmpv || true

	for i in $fstabq $fstabd; do
		if [ -f $i ]; then
		send_log "Find $i"
			if [[ ! $(grep "/userdata" $i | grep ":v2") = "" ]]; then
				send_log "ROM FBE v2 support..."
				finish
			else
				send_log "Change to FBE v1 support..."
				sed -i "s|fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized,keydirectory=/metadata/vold/metadata_encryption|fileencryption=ice,reservedsize=128M|" $fstabr
				#sed -i "/by-name\/metadata/d" $fstabr
				if [[ ! $(grep "/userdata" $i | grep wrappedkey) = "" ]]; then
					send_log "...and enabled wrappedkey."
					sed -i -e "s/formattable/formattable,wrappedkey/g" $fstabr
				fi
				finish
			fi
		fi
	done
}

patch_fstab

exit 0
