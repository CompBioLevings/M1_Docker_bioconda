# We will use Ubuntu for our image
FROM ubuntu:20.04

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade

# Adding wget and bzip2
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget bzip2 libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libxdamage1 libasound2 libxi6 libxtst6 libsm6 libxext6 libpci-dev libcairo2-dev ffmpeg x11-apps

# Anaconda installing
RUN wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
RUN bash Anaconda3-2022.05-Linux-x86_64.sh -b
RUN rm Anaconda3-2022.05-Linux-x86_64.sh

# Set path to conda
ENV PATH /root/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda

# Now add channels
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

# Now install libraries for standard python development/coding and update
RUN conda install mamba
ADD ./base_environment.yml .
RUN mamba env update --file base_environment.yml --prune 
# RUN mamba install -y cairo font-ttf-ubuntu fonts-conda-ecosystem fonts-conda-forge fonttools freetype gsl ipykernel ipython ipython_genutils ipywidgets isort loompy matplotlib matplotlib-base matplotlib-inline mscorefonts napari notebook numpy openpyxl pandas pandoc plotnine pybedtools pybigwig pygenometracks python-dateutil readline regex scikit-image scikit-learn scipy spyder spyder-kernels sqlite statsmodels xlsxwriter xorg-kbproto xorg-libx11 xorg-libxau xorg-libxdmcp xorg-xproto
# RUN mamba upgrade --all -y

# Now create an additional virtual environment with non-standard packages for doing bioinformatic work
ADD ./deeptools_environment.yml .
RUN mamba env create -f deeptools_environment.yml
# RUN conda create -n deeptools python=3.9 
# RUN mamba install -n deeptools -y bedops bedtools cairo deeptools deeptoolsintervals htslib isort macs2 parallel s3transfer salmon samtools ucsc-bedclip ucsc-bedgraphtobigwig ucsc-bedtogenepred ucsc-bigwigmerge ucsc-genepredtogtf ucsc-liftover ucsc-wigtobigwig wiggletools xorg-kbproto xorg-libx11 xorg-libxau xorg-libxdmcp xorg-xproto
# RUN mamba upgrade --all -y -n deeptools

# Now initiate conda usage so that the base environment activates by default
SHELL ["/bin/bash","-c"]
RUN conda init

# There is a strange inconsistency with h5py, so I will uninstall and reinstall using pip
RUN pip uninstall h5py -y
RUN pip install --no-cache-dir h5py

# Also pip install patchworklib (only available through pip)
RUN pip install --no-cache-dir patchworklib

# now cleanup/remove extra/unnecessary baggage downloaded
RUN conda clean --all -y

# Turn off auto-activate base
RUN conda config --set auto_activate_base False

# And add environment variable to allow spyder running without sandbox mode
RUN echo "export QTWEBENGINE_DISABLE_SANDBOX=1" >> ${HOME}/.bashrc
