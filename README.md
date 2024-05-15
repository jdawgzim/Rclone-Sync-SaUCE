# Rclone-Sync-SaUCE
Use Rclone sync to shrink down some of the sauces to fit on a smaller USB drive.

## Resauce the OnesaUCE with Rclone
These instructions are written for Windows but rclone sync works in other OSes too. I use Rclone-Sync-SaUCE to fit more systems on a smaller USB flash drive for my AtGames Legends Ultimate Arcade. This is written for One Sauce v2 but can be easily adjusted to work with other rom/emulator builds.

TLDR: Basically create a Rclone filter list to use with "rclone sync" command to filter out roms and their associated artwork/videos.

1. Create a tempmain folder on your Windows PC. Create three folders: "onesauce2", "txt" and "old".
2. Put rclone.exe in the tempmain folder or install rclone so it can be executed anywhere.
3. Combine all onesauce version 2 downloads into "onesauce2" folder
4. Output list of each rom pack. (Some of these filter txt files are included above in the txt folder) e.g.
	1. dir /B "onesauce2\content\retrofe\collections\Daphne\roms" > txt\daphne.txt
	2. dir /B "OneSauce2\content\retrofe\collections\Sony PSP Minis\roms\\*.CSO" > txt\pspmini.txt
5. format lists according to https://rclone.org/filtering/ Use + or - at beginiing of each line to add or remove. Use **  to specify etc. e.g.
	1. \- Commodore 64/\*\*/5th Gear**
	2. \+ Commodore 64/\*\*/720 Degrees**
	3. \- Commodore 64/\*\*/747 Flight Simulator**
6. Recommend installing vscode. vscode supports multi line edits and regex find and replace/delete. Hit CTRL-h to use find/replace.
7. Careful not to filter out system stuff like "cheats". Make sure your filter is focusing on rom filenames without the extensions.
8. Replace problematic characters like !, $, #, &, etc with ? or delete them if they are at end of filenames.
9. Remove rom extensions like .img then remove [], {}, and () with included text at the end of filenames. 
	1. \s\\([^)]*\\) is a regex to find things in parentheses 
	2. \s\\[[^)]*\\] is a regex to find things in square brackets
	3.  https://regex-generator.olafneumann.org/
10. Edit base_to_flash.bat and collection_to_flash.bat to specify the correct flash directory. Replace \<flash drive letter\> with the correct flash drive letter in the batch files
11. Use base_to_flash.bat to move your main files to your flash drive.
12. Use collection_to_flash.bat to move your rom files to your flash drive.
13. Check the log files to see if it looks right.
14. Remove --dry-run from the sync commands in the batch files when it seems like it's work right.
15.WizTree (or Windirstat) is great way to analyze the results

## Rclone Gotchas:
- Have to use forward slashes most of the time
- Have to specify directory and use /**/ to catch multiple directories
- Have to search by rom extension to get real list of files
- -v --log-file=file.log to review what it did because output is large
- not excluded files not in source get removed in destination
- excluded files don't get removed in destination by default
- --delete-excluded forces excluded files to be removed in destination
- Filter lists are case sensitive
- !, &, $, #, etc. are bad so delete or replace with ?
