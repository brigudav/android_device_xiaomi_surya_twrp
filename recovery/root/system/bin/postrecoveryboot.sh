#!/system/bin/sh
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2019-2022 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
#
# TODO: this kludge is needed to prevent issues with mounting
# system and vendor in some zip installers and in the gui
#

set_read_write_partitions() {
  local i=$(getprop "ro.orangefox.fastbootd");
  [ "$i" = "1" ] && return; # don't run this in fastbootd mode

  local Parts="system system_ext vendor product";
  for i in ${Parts}
  do
     echo "I:OrangeFox: setting $i to read/write" >> /tmp/recovery.log;
     blockdev --setrw /dev/block/mapper/$i;
  done
}

set_read_write_partitions;
exit 0;
