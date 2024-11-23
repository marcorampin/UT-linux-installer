echo 'Checking dependencies...'

if pacman -Q coreutils &>/dev/null; then
	echo -e '\xE2\x9C\x94 coreutils'
else
	echo 'coreutils missing'
	exit 0
fi
if pacman -Q wget &>/dev/null; then
	echo -e '\xE2\x9C\x94 wget'
else
	echo 'wget missing'
	exit 0
fi
if pacman -Q unzip &>/dev/null; then
	echo -e '\xE2\x9C\x94 unzip'
else
	echo 'unzip missing'
	exit 0
fi
if pacman -Q tar &>/dev/null; then
	echo -e '\xE2\x9C\x94 tar'
else
	echo 'tar missing'
	exit 0
fi

FOLD_NAME='Unreal_tournament'
ZIP_NAME='unreal_tournament.zip'
TAR_NAME='patch.tar.bz2'
UT_ZIP=./$ZIP_NAME
PATCH_TAR=./$FOLD_NAME/$TAR_NAME 

# Unreal tournament files from Archive.org
echo 'Downloading UT99 files...'
wget -nv "https://archive.org/download/unreal-tournament-complete/Unreal%20Tournament.zip"
echo -e '\xE2\x9C\x94 UT99 files downloaded'

echo 'Extracting files...'
mv ./'Unreal Tournament.zip' ./$ZIP_NAME
unzip -q $UT_ZIP
mv ./'Unreal Tournament' ./$FOLD_NAME
echo -e '\xE2\x9C\x94 Files extracted'

# Patch 469d
echo 'Downloading 469d patch...'
wget -P ./$FOLD_NAME -nv "https://github.com/OldUnreal/UnrealTournamentPatches/releases/download/v469d/OldUnreal-UTPatch469d-Linux-amd64.tar.bz2"
echo -e '\xE2\x9C\x94 Patch downloaded'

echo 'Extracting and adding patch...'
mv ./$FOLD_NAME/*.tar.bz2 ./$FOLD_NAME/$TAR_NAME
tar -xf $PATCH_TAR -C ./$FOLD_NAME/ --overwrite
echo -e '\xE2\x9C\x94 Patch added'

echo 'Removing windows files...'
rm ./$FOLD_NAME/System/*.dll
rm ./$FOLD_NAME/System/*.exe
echo -e '\xE2\x9C\x94 Windows files removed'

echo 'Deleting compressed folders...'
rm $UT_ZIP
rm $PATCH_TAR
echo -e '\xE2\x9C\x94 Compressed folders deleted'

echo -e '\xE2\x9C\x94 Installation completed, execute '$FOLD_NAME'/System64/ut-bin-amd64 to play'
