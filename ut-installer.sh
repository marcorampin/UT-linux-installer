FOLD_NAME='Unreal_tournament'
ZIP_NAME='unreal_tournament.zip'
TAR_NAME='patch.tar.bz2'
UT_ZIP=./$ZIP_NAME
PATCH_TAR=./$FOLD_NAME/$TAR_NAME 

# Unreal tournament files from Archive.org
wget -nv "https://archive.org/download/unreal-tournament-complete/Unreal%20Tournament.zip"

mv ./'Unreal Tournament.zip' ./$ZIP_NAME
unzip -q $UT_ZIP
mv ./'Unreal Tournament' ./$FOLD_NAME

# Patch 469d
wget -P ./$FOLD_NAME -nv "https://github.com/OldUnreal/UnrealTournamentPatches/releases/download/v469d/OldUnreal-UTPatch469d-Linux-amd64.tar.bz2"

mv ./$FOLD_NAME/*.tar.bz2 ./$FOLD_NAME/$TAR_NAME
tar -xf $PATCH_TAR -C ./$FOLD_NAME/ --overwrite

rm ./$FOLD_NAME/System/*.dll
rm ./$FOLD_NAME/System/*.exe

rm $UT_ZIP
rm $PATCH_TAR
