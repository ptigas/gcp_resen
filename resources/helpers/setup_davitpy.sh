#!/bin/bash
#######################################################################################
#
#    A helper script for installing davitpy
#
#    Assumes you have a py27 python virtual environment
#
#######################################################################################

source ${HOME}/envs/py27/bin/activate
CURDIR=$(pwd)
DAVITPY_BUILD_DIR=${CURDIR}/davitpy_build

git clone https://github.com/vtsuperdarn/davitpy.git $DAVITPY_BUILD_DIR
cd $DAVITPY_BUILD_DIR
git checkout tags/0.8-master -b 0.8-master

pip install .

# get hdw.dat and radar.dat - needed so davitpy can get radar information locally
mkdir -p ${HOME}/cache
cd ${HOME}/cache
git clone https://github.com/vtsuperdarn/hdw.dat.git
wget https://raw.githubusercontent.com/SuperDARN/rst/v4.2/tables/superdarn/radar.dat

deactivate

# cleanup
cd ${CURDIR}
rm -rf $DAVITPY_BUILD_DIR
rm ${HOME}/.wget-hsts

# set nessisary environment variables
echo "SD_HDWPATH=${HOME}/cache/hdw.dat" >> ${HOME}/.bashrc
echo "SD_RADAR=${HOME}/cache/radar.dat" >> ${HOME}/.bashrc