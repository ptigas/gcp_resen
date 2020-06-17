FROM gcr.io/deeplearning-platform-release/pytorch-gpu.1-0

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN apt-get update && apt-get -y install tzdata && rm -rf /var/lib/apt/lists/*

# Install some system utilities
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    less vim zip \
    curl \
    autoconf libtool pkg-config \
    bash-completion \
    gfortran \
    rsync \
    mlocate && \
    rm -rf /var/lib/apt/lists/*

# Install python stuff
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    python2.7 python3.6 \
    python-virtualenv python3-virtualenv \
    python-setuptools python3-setuptools \
    python-dev python3-dev \
    libproj-dev proj-data proj-bin \
    libgeos++-dev libgeos-dev \
    libdb-dev \
    python-tk python3-tk && \
    rm -rf /var/lib/apt/lists/*

# Install system libraries needed by python packages
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    libncurses5-dev && \
    rm -rf /var/lib/apt/lists/*


# Install the NASA CDF library
USER root
COPY resources/helpers/install_CDF.sh .
COPY resources/cdf.sh /etc/profile.d
RUN /bin/bash -c 'bash install_CDF.sh && rm install_CDF.sh'


# Install basemap
COPY resources/helpers/setup_basemap.sh .
RUN /bin/bash -c 'bash setup_basemap.sh && rm setup_basemap.sh'

# Install davitpy (only works on python2.7):
COPY resources/helpers/setup_davitpy.sh .
RUN /bin/bash -c 'bash setup_davitpy.sh && rm setup_davitpy.sh'

# Install pyglow
COPY resources/helpers/setup_pyglow.sh .
RUN /bin/bash -cl 'bash setup_pyglow.sh && rm setup_pyglow.sh'

# create work directory for user
#RUN mkdir /home/$NB_USER/work

# set default python environment to py36
#RUN /bin/bash -c 'echo "source /home/$NB_USER/envs/py36/bin/activate" >> /home/$NB_USER/.bashrc'
RUN pip install cartopy

# post installation stuff
# Download 110m scale cartopy data
COPY resources/feature_download.py .
RUN /bin/bash -cl 'python feature_download.py physical cultural cultural-extra --do_scales 110m && \
                   rm feature_download.py'
