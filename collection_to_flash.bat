type txt\*.txt > all.txt
move /Y collections.log old
rclone sync -v --filter-from=all.txt --delete-excluded --delete-during --log-file=collections.log onesauce2\content\retrofe\collections F:\content\retrofe\collections
move /Y screensaver.log old
rclone sync -v --filter-from=txt\screensaver.txt --delete-excluded --delete-during --log-file=screensaver.log onesauce2\ha8800_screensaver F:\ha8800_screensaver
