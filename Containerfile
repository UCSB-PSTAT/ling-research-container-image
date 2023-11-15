FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

RUN apt update && \
    apt install -y \
        git \
        wget \
        tcsh \
        gawk \
        tar \
        make && \
    apt-get clean

#-- Install SRILM
RUN mkdir /usr/bin/srilm
WORKDIR /usr/bin/srilm
RUN wget https://sjtodd.github.io/ling110/srilm-1.7.3.tar.gz && \
    tar xvf srilm-1.7.3.tar.gz && \
    sed -i '1i SRILM = /usr/bin/srilm' Makefile && \
    make MAKE_PIC=yes World && \
    make cleanest 

RUN pip install gensim \
    scikit-learn \
    pytest \
    PTable \
    nltk \
    arpa \
    morfessor \
    tensorflow \
    keras \
    spacy \
    textgrid \
    tgt
    
# Because Pytorch is special:
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

RUN R -e "install.packages(c('bayestestR', 'blockcluster', 'ca', 'CCA', 'cowplot', 'DirichletReg', 'doParallel', 'ellipse', 'factoextra', 'FactoMineR', 'ggalluvial', 'GGally', 'ggbreak', 'ggfittext', 'ggforce', 'ggmosaic', 'ggpattern', 'ggplot2', 'ggrepel', 'ggthemes', 'ggVennDiagram', 'ggwordcloud', 'glossr', 'keras', 'lmerTest', 'mclust', 'ordinal', 'plotly', 'pvclust', 'reticulate', 'sunburstR', 'rjson', 'see', 'spacyr', 'vowels'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

USER $NB_USER

# Set environment variables for SRILM
ENV LC_NUMERIC=C \
    PATH=$PATH:/usr/bin/srilm/bin:/usr/bin/srilm/bin/i686-m64
WORKDIR /home/jovyan
