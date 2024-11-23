# ut99-linux-installer
To do:
- [X] download files
- [X] unzip UT and patch files, then merge them in separate folder
- [X] remove windows files (.dll & .exe) from System folder
- [X] remove compressed files

Extra:
- [X] check if dependencies are installed
- [ ] Add connection time limit
- [ ] check system (amd64, arm64, x86) and download the correct patch
- [X] print statement for each started and completed step
- [ ] ask if .desktop and .appmenu links need to be created
- [ ] ask if compressed folders need to be deleted
- [ ] say which file needs to be executed to start the game

Dependencies:
- coreutils
- tar
- unzip
- wget
