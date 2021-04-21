#!/bin/bash

# This export can be deleted after the statusteam/nim-status-client-build
# docker image has been updated
export QTDIR="${QT_PATH}/${QT_VERSION}/${QT_PLATFORM}"

# Workaround for permissions problems with `jenkins` user inside the container
cp -R . ~/status-desktop
cd ~/status-desktop

git clean -dfx && rm -rf vendor/* && make -j4 V=1 update
make V=1 pkg

# Make AppImage build accessible to the docker host
cd - && cp -R ~/status-desktop/pkg .
chmod -R 775 ./pkg
