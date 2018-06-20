#!/bin/bash

# Copyright (c) 2018, spycrab0
# Licensed under the MIT License

STEPS=6
APPDIR=./Dolphin.AppDir

echo "Cleaning up..."
rm -rf $APPDIR
echo "[1/$STEPS] Creating $APPDIR folder structure"
mkdir $APPDIR
echo "[2/$STEPS] Configuring Dolphin"
cmake -DENABLE_WX=OFF -DLINUX_LOCAL_DEV=TRUE ..
echo "[3/$STEPS] Building Dolphin"
make -j3
echo "[4/$STEPS] Copying / Creating AppImage files"
cp -v ./Binaries/dolphin-emu $APPDIR
cp -v ../Data/dolphin-emu.desktop $APPDIR/dolphin.desktop
cp -v ../Data/dolphin-emu.png $APPDIR
cp -vr ../Data/Sys $APPDIR

if [ ! -f "linuxdeployqt" ]; then
echo "[5/$STEPS] Downloading linuxdeployqt"
wget https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage -O linuxdeployqt
chmod +x linuxdeployqt
else
echo "[5/$STEPS] linuxdeployqt already present"
fi
echo "[6/$STEPS] Creating AppImage"
./linuxdeployqt ./Dolphin.AppDir/dolphin.desktop -appimage
