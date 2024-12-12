# ut99-linux-installer

Welcome! You are about to begin the installation of Unreal Tournament GOTY Edition.

This game requires 1.3 GB of disk space for setup.

Game data and patches will be downloaded from the Internet.

The installer will apply the latest community patch.

Copy the script in the path where you want to keep your game files.

The script can be both executed with terminal or without terminal (double-click).
The first case permits to:
	1) visually see the progression of the installation;
	2) decide wether to create .desktop and application entries;
	3) delete the downloaded files (game and patch files).
The second instead automatically decides to create .desktop and and application entries and to delete the downloaded files. There are no messages of completed installation (aside from those signals).

The installation also creates an uninstall script that removes the whole game folder and the .desktop and application entries.

NOTICE
The script has the following dependencies (on arch linux it checks if they are installed):
	- bash (didn't test with other shells)
	- coreutils
	- jq
	- tar
	- unzip
	- wget
