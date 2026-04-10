#!/bin/bash

set -e

# check linuxdeploy-x86_64.AppImage exists
if [ ! -f linuxdeploy-x86_64.AppImage ]; then
    echo "linuxdeploy-x86_64.AppImage not found. Downloading..."
    wget -c "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage" -O linuxdeploy-x86_64.AppImage
fi
chmod +x linuxdeploy-x86_64.AppImage

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "SCRIPT_DIR=" $SCRIPT_DIR

BUILD_PWD="${SCRIPT_DIR}/../../build/bin/"
APP_IMAGE_DIR="${SCRIPT_DIR}"
echo "BUILD_PWD=" $BUILD_PWD
echo "APP_IMAGE_DIR=" $APP_IMAGE_DIR

cd $SCRIPT_DIR # change cwd to script directory

PLAYER_APP_IMAGE_DIR_NAME="sample-player-x86_64"
mkdir -p $PLAYER_APP_IMAGE_DIR_NAME
COACH_APP_IMAGE_DIR_NAME="sample-coach-x86_64"
mkdir -p $COACH_APP_IMAGE_DIR_NAME
TRAINER_APP_IMAGE_DIR_NAME="sample-trainer-x86_64"
mkdir -p $TRAINER_APP_IMAGE_DIR_NAME

echo "Start to create app image for player"
./linuxdeploy-x86_64.AppImage --appdir ./$PLAYER_APP_IMAGE_DIR_NAME \
                                -e $BUILD_PWD/sample_player \
                                -d $APP_IMAGE_DIR/sample_player.desktop \
                                -i $APP_IMAGE_DIR/sample_player.png \
                                --output appimage 

echo "Start to create app image for coach"
./linuxdeploy-x86_64.AppImage --appdir ./$COACH_APP_IMAGE_DIR_NAME \
                                -e $BUILD_PWD/sample_coach \
                                -d $APP_IMAGE_DIR/sample_coach.desktop \
                                -i $APP_IMAGE_DIR/sample_coach.png \
                                --output appimage 

echo "Start to create app image for trainer"
./linuxdeploy-x86_64.AppImage --appdir ./$TRAINER_APP_IMAGE_DIR_NAME \
                                -e $BUILD_PWD/sample_trainer \
                                -d $APP_IMAGE_DIR/sample_trainer.desktop \
                                -i $APP_IMAGE_DIR/sample_trainer.png \
                                --output appimage 
echo "App Image Created."

echo "Start to create all in one."
cp ${BUILD_PWD} -r soccer-simulation-proxy
rm  soccer-simulation-proxy/sample_player
rm  soccer-simulation-proxy/sample_coach
rm  soccer-simulation-proxy/sample_trainer
mv sample_coach-x86_64.AppImage soccer-simulation-proxy/sample_coach
mv sample_player-x86_64.AppImage soccer-simulation-proxy/sample_player
mv sample_trainer-x86_64.AppImage soccer-simulation-proxy/sample_trainer

chmod 777 soccer-simulation-proxy/*

rm -rf $PLAYER_APP_IMAGE_DIR_NAME
rm -rf $COACH_APP_IMAGE_DIR_NAME
rm -rf $TRAINER_APP_IMAGE_DIR_NAME

# create tar file
tar -czvf soccer-simulation-proxy.tar.gz soccer-simulation-proxy/*

# create zip file
if [ -x "$(command -v zip)" ]; then
    zip -r soccer-simulation-proxy.zip soccer-simulation-proxy/*
fi

# create 7z file
if [ -x "$(command -v 7z)" ]; then
    7z a soccer-simulation-proxy.7z soccer-simulation-proxy/*
fi

echo "All in one created."