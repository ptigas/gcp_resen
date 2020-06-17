#!/bin/bash
#######################################################################################
#
#    A helper script for installing pyglow
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

echo "**** Installing pyglow ****"

PYGLOW_BUILD_DIR=pyglow_build

git clone https://github.com/timduly4/pyglow.git $PYGLOW_BUILD_DIR
cd $PYGLOW_BUILD_DIR
git checkout 054bf800263c01ecfa783741c9cfe8d3d6c259ca -b master_20190904

make -C src/pyglow/models source
pip install .
python -c "import pyglow"

# cleanup
cd $BUILD
