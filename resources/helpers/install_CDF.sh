#!/bin/bash
#######################################################################################
#
#    A helper script for installing the NASA CDF library.
#
#
#    Currently installs the CDF library from:
#
#    http://spdf.sci.gsfc.nasa.gov/pub/software/cdf/dist/
#
#######################################################################################

CDF_DIRNAME=cdf36_4-dist
CDF_TAR_FILENAME=${CDF_DIRNAME}-cdf.tar.gz

wget https://spdf.sci.gsfc.nasa.gov/pub/software/cdf/dist/cdf36_4/linux/${CDF_TAR_FILENAME}
tar -xvf ${CDF_TAR_FILENAME}
cd ${CDF_DIRNAME}
make OS=linux ENV=gnu all
make INSTALLDIR=/usr/local install
cd ..
rm -rf ${CDF_DIRNAME} ${CDF_TAR_FILENAME}

echo "if [ -z \$CDF_LIB ]; then source /usr/local/bin/definitions.B; fi" >> /home/$NB_USER/.bashrc
