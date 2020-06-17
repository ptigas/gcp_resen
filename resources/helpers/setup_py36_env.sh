#!/bin/bash
#######################################################################################
#
#    A helper script for setting up a python 3.6 environment
#
#######################################################################################

echo "**** Installing python 3.6 packages ****"

# upgrade pip
pip install pip==19.3.1

# Now use pip to install everything we can
# Notes: pyproj==1.9.6 required for basemap, 2.0.0 breaks basemap
pip install -U jupyterhub==1.0.0 \
               jupyterlab==1.1.4 \
               notebook==6.0.1 \
               paramiko==2.4.2 \
               ipython==7.4.0 \
               pymongo==3.7.2 \
               mechanize==0.4.1 \
               cryptography==2.6.1 \
               pytest==4.3.1 \
               nbformat==4.4.0 \
               numpy==1.16.2 \
               matplotlib==2.2.4 \
               scipy==1.2.1 \
               tables==3.5.1 \
               sgp4==1.4 \
               pandas==0.24.2 \
               sympy==1.1.0 \
               sqlalchemy==1.3.1 \
               h5py==2.9.0 \
               pytz==2018.9 \
               netcdf4==1.4.3 \
               bokeh==1.0.4 \
               pyyaml==5.1 \
               cython==0.29.6 \
               pyproj==1.9.6 \
               madrigalweb==3.1.10 \
               cartopy==0.17.0 \
               bsddb3==6.2.6 \
               aacgmv2==2.5.2 \
               pymap3d==2.1.0
               astropy==3.2.1

# Custom pip installation for any package that needs it
pip install apexpy==1.0.3  # have to install after installing numpy

pip install spacepy==0.2.1
source /usr/local/bin/definitions.B # to set the CDF definitios including $CDF_LIB
# only update omni and qin-denton since maia.usno.navy.mil/ser7/tai-utc.dat leapseconds website was down at the time...
python -uc "import spacepy.toolbox; spacepy.toolbox.update(QDomni=True)"
# spacepy 0.2.1 doesn't clean up this file. Submitted issue and PR to spacepy, see https://github.com/spacepy/spacepy/pull/219
rm OMNI_OMNI2_merged_20120213-v1.cdf

# Installing mangopy (14 June 2018)
pip install git+https://github.com/astib/MANGO.git@2dd4ca5380dca54cac8d2180c3ad63fc041a5c67

# cleanup
rm -rf ~/.cache/pip/*