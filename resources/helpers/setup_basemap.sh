#!/bin/bash
#######################################################################################
#
#    A helper script for installing basemap
#
#    Assumes you have py27 and py36 python virtual environments
#
#######################################################################################

# git clone --depth 0 https://github.com/matplotlib/basemap.git # VERY SLOW
wget https://github.com/matplotlib/basemap/archive/v1.2.0rel.tar.gz
tar -zxf v1.2.0rel.tar.gz
cd basemap-1.2.0rel

source ${HOME}/envs/py27/bin/activate
pip install .

deactivate

source ${HOME}/envs/py36/bin/activate
pip install .

deactivate

# cleanup
cd ..
rm -rf basemap-1.2.0rel v1.2.0rel.tar.gz
rm ${HOME}/.wget-hsts
