type txt\*.txt > all.txt
move /Y collections.log old
rclone sync -v --filter-from=all.txt --delete-excluded --delete-during --log-file=collections.log --dry-run onesauce2\content\retrofe\collections <flash drive letter>:\content\retrofe\collections
move /Y screensaver.log old
rclone sync -v --filter-from=txt\screensaver.txt --delete-excluded --delete-during --log-file=screensaver.log --dry-run onesauce2\ha8800_screensaver <flash drive letter>:\ha8800_screensaver
