move /Y base.log old
rclone sync -v --exclude "content/retrofe/collections/**" --exclude "/System Volume Information/**" --exclude "ha8800_screensaver/**" --exclude "favorites.txt" --log-file=base.log --dry-run onesauce2 <flash drive letter>:\
