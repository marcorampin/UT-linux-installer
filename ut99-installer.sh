#!/bin/bash

checkDependencies() {
	echo 'Checking dependencies...'
	if [ $( grep -c 'Arch Linux' /etc/os-release ) -gt 0 ]; then
		if pacman -Q coreutils &>/dev/null; then
			echo -e '\xE2\x9C\x94 coreutils'
		else
			echo 'coreutils missing'
			exit 0
		fi
		if pacman -Q tar &>/dev/null; then
			echo -e '\xE2\x9C\x94 tar'
		else
			echo 'tar missing'
			exit 0
		fi
		if pacman -Q unzip &>/dev/null; then
			echo -e '\xE2\x9C\x94 unzip'
		else
			echo 'unzip missing'
			exit 0
		fi
		if pacman -Q wget &>/dev/null; then
			echo -e '\xE2\x9C\x94 wget'
		else
			echo 'wget missing'
			exit 0
		fi
	fi
}

setVariables() {
	curr_path=$(pwd)
	fold_name='Unreal_tournament'
	zip_name='unreal_tournament.zip'
	patch_ver='469d'
	tar_name='patch'$patch_ver'.tar.bz2'
	ut99_zip=./$zip_name
	patch_tar=./$fold_name/$tar_name 
	architecture=$(uname -m)
}

# Unreal tournament files from Archive.org
getUTFiles() {
	echo 'Downloading UT99 files...'
	wget -nv --show-progress 'https://archive.org/download/unreal-tournament-complete/Unreal%20Tournament.zip'
	echo -e '\xE2\x9C\x94 UT99 files downloaded'

	echo 'Extracting files...'
	mv ./'Unreal Tournament.zip' ./$zip_name
	unzip -q $ut99_zip
	mv ./'Unreal Tournament' ./$fold_name
	echo -e '\xE2\x9C\x94 Files extracted'
}

# Patch 469d
getPatch() {
	echo 'Downloading '$patch_ver' patch...'
	if [[ $architecture == 'x86_64' ]]; then
    	arc_suffix='amd64'
    	system_suffix='64'
	elif [[ $architecture == 'arm64' ]]; then
    	arc_suffix='arm64'
    	system_suffix='ARM64'
	elif [[ $architecture == 'i686' ]]; then
    	arc_suffix='x86'
    	system_suffix=''
	else
    	echo 'Unknown architecture'
    	exit 0
	fi

	wget -P ./$fold_name -nv --show-progress 'https://github.com/OldUnreal/UnrealTournamentPatches/releases/download/v'$patch_ver'/OldUnreal-UTPatch'$patch_ver'-Linux-'$arc_suffix'.tar.bz2'
	echo -e '\xE2\x9C\x94 Patch downloaded'

	echo 'Extracting and adding patch...'
	mv ./$fold_name/*.tar.bz2 ./$fold_name/$tar_name
	tar -xf $patch_tar -C ./$fold_name/ --overwrite
	echo -e '\xE2\x9C\x94 Patch added'
}

deleteWinFiles() {
	echo 'Removing windows files...'
	rm ./$fold_name/System/*.dll
	rm ./$fold_name/System/*.exe
	echo -e '\xE2\x9C\x94 Windows files removed'
}

addLinks() {
	read -p 'Add a .desktop entry?(Y/n) ' desktop_entry
	read -p 'Add a menu entry?(Y/n) ' app_entry
	
	if [[ -z $desktop_entry ]]; then
    	desktop_entry='y'
	fi
	if [[ -z $app_entry ]]; then
    	app_entry='y'
	fi

	if [[ $desktop_entry =~ ^[Yy]$ || $app_entry =~ ^[Yy]$ ]]; then
    	echo 'Creating entry...'
    	echo '[Desktop Entry]' > UT99.desktop
    	echo 'Version=469d' >> UT99.desktop
    	echo 'Name=Unreal Tournament' >> UT99.desktop
    	echo 'Comment=Unreal Tournament' >> UT99.desktop
    	echo 'Exec='$curr_path/$fold_name/'System'$system_suffix'/ut-bin-'$arc_suffix >> UT99.desktop
		echo 'Icon='$curr_path/$fold_name/'System/Unreal.ico' >> UT99.desktop
	    echo 'Terminal=false' >> UT99.desktop
	    echo 'Type=Application' >> UT99.desktop
	    echo 'Categories=ApplicationCategory;' >> UT99.desktop
	    chmod +x UT99.desktop

	    if [[ $desktop_entry =~ ^[Yy]$ ]]; then
	    	cp UT99.desktop ~/Desktop/
	    	echo -e '\xE2\x9C\x94 .desktop entry created'
	    fi
    
	    if [[ $app_entry =~ ^[Yy]$ ]]; then
	    	cp UT99.desktop ~/.local/share/applications/
	    	echo -e '\xE2\x9C\x94 Menu entry created'
	    fi
	    rm UT99.desktop
	fi
}

deleteDownFiles() {
	read -p 'Delete downloaded files?(Y/n) ' del_download
	
	if [[ -z $del_download ]]; then
    	del_download='y'
	fi

	if [[ $del_download =~ ^[Yy]$ ]]; then
		echo 'Deleting downloaded files...'
		rm $ut99_zip
		rm $patch_tar
		echo -e '\xE2\x9C\x94 Downloaded files deleted'
	fi
}

addUninstall() {
	echo 'Creating uninstall script...'
	echo 'rm -r ../'$fold_name > uninstall.sh
	echo 'rm ~/Desktop/UT99.desktop' >> uninstall.sh
	echo 'rm ~/.local/share/applications/UT99.desktop' >> uninstall.sh
	chmod +x uninstall.sh
	mv uninstall.sh ./$fold_name
	echo -e '\xE2\x9C\x94 Uninstalling script created'
}


checkDependencies
setVariables
getUTFiles
getPatch
deleteWinFiles
addLinks
deleteDownFiles
addUninstall

echo -e '\xE2\x9C\x94 Installation completed, execute '$fold_name'/System'$system_suffix'/ut-bin-'$arc_suffix' to play'
