# ut99-linux-installer

Dependencies:
- bash
- coreutils
- jq
- tar
- unzip
- wget

To do:
- [X] download files
- [X] unzip UT and patch files, then merge them in separate folder
- [X] remove windows files (.dll & .exe) from System folder
- [X] remove compressed files

Extra:
- [X] check if dependencies are installed
- [X] check system (amd64, arm64, x86) and download the correct patch
- [X] print statement for each started and completed step
- [X] ask if .desktop and .appmenu links need to be created
- [X] ask if compressed folders need to be deleted
- [X] say which file needs to be executed to start the game
- [X] create uninstall script
