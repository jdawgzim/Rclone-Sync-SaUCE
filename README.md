# Rclone-Sync-SaUCE
Use Rclone sync to shrink down some of the sauces to fit on a smaller USB drive.
Resauce the OnesaUCE with Rclone
Use Rclone sync to shrink down some of the sauces to fit on a smaller USB drive. These instructions are written for Windows but rclone sync works in other OSes too.

TLDR: Basically create a Rclone filter list to use with "rclone sync" command to filter out roms and their associated artwork/videos.

1. Organize a main folder on your Windows PC with rclone.exe in it and create three folders: "onesauce2", "txt" and "old".
2. Combine all onesauce version 2 downloads into "onesauce2" folder
3. Output list of each rom pack 
	1. dir /B "onesauce2\content\retrofe\collections\Daphne\roms" > txt\daphne.txt
	2. dir /B "OneSauce2\content\retrofe\collections\Sony PSP Minis\roms\*.CSO" > txt\pspmini.txt
4. format lists according to https://rclone.org/filtering/ Use + or - at beginiing of each line to add or remove. Use **  to specify etc. Format each line like below:
	1. \- Sega Genesis/**/Altered Beast** 
5. Recommend installing vscode. vscode supports multi line edits and regex find and replace/delete
6. Careful not to filter out system stuff like "cheats" or other non-rom name files
7. Replace problematic characters like !, $, #, &, etc with ? or delete them if they are at end of filenames.
8. Remove extensions like .img then remove [], {}, and () with included text at the end of filenames
	1. \s\([^)]*\) is a regex to find things in parentheses 
	2. \s\[[^)]*\] is a regex to find things in square brackets
	3.  https://regex-generator.olafneumann.org/
9. You could put the commands below in a .bat file and run in Windows Command Console in the main folder.
10. Sync over everything except packages. Change J:\ to your usb drive. Warning this will wipe J:\
	1. move /Y base.log old
	2. rclone sync -v --exclude "content/retrofe/collections/**" --exclude "/System Volume Information/**" --exclude "ha8800_screensaver/**" --log-file=base.log --dry-run onesauce2 J:\
	3. Remove --dry-run when base.log looks good
11. Create and run batch file:
	1. type txt\*.txt > all.txt
	2. move /Y collections.log old
	3. rclone sync -v --filter-from=all.txt --delete-excluded --delete-during --log-file=collections.log onesauce2\content\retrofe\collections J:\content\retrofe\collections
	4. move /Y screensaver.log old
	5. rclone sync -v --filter-from=txt\screensaver.txt --delete-excluded --delete-during --log-file=screensaver.log onesauce2\ha8800_screensaver J:\ha8800_screensaver
	6. Remove --dry-run when results are looking good in collections.log
12. WizTree (or Windirstat) is great way to analyze the results

## Rclone Gotchas:
- Have to use forward slashes sometimes
- Have to specify directory and use /**/ to catch multiple directories
- Have to search by rom extension to get real list of files
- -v --log-file=file.log to review what it did because output is large
- not excluded files not in source get removed in destination
- excluded files don't get removed in destination by default
- --delete-excluded forces excluded files to be removed in destination
- Filter lists are case sensitive
- !, &, $, #, etc. are bad so delete or replace with ?
