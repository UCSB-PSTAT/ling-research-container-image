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
        make \
        libopenblas-dev && \
    apt-get clean

#-- Install SRILM
RUN mkdir /usr/bin/srilm
WORKDIR /usr/bin/srilm
RUN wget https://sjtodd.github.io/ling110/srilm-1.7.3.tar.gz && \
    tar xvf srilm-1.7.3.tar.gz && \
    sed -i '1i SRILM = /usr/bin/srilm' Makefile && \
    make MAKE_PIC=yes World && \
    make cleanest 

RUN pip install gensim spacy

RUN conda install -y \
    scikit-learn \
    pytest \
    ptable \
    nltk \
    morfessor \
    pytorch \
    tensorflow-cpu \
    torchaudio \
    torchvision \
    keras \
    textgrid
    
# Because Pytorch is special:
RUN pip install arpa tgt

# Hopefully temporary workaround
RUN R -e "install.packages('rtkore',repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores()); install.packages('https://cran.r-project.org/src/contrib/Archive/blockcluster/blockcluster_4.5.4.tar.gz', repos=NULL, type='source', Ncpus = parallel::detectCores())"

RUN R -e "install.packages(c('bayestestR', 'ca', 'CCA', 'cowplot', 'devtools', 'DirichletReg', 'doParallel', 'ellipse', 'factoextra', 'FactoMineR', 'ggalluvial', 'GGally', 'ggbreak', 'ggfittext', 'ggforce', 'ggmosaic', 'ggpattern', 'ggplot2', 'ggrepel', 'ggthemes', 'ggVennDiagram', 'ggwordcloud', 'glossr', 'keras', 'lmerTest', 'mclust', 'ordinal', 'plotly', 'pvclust', 'reticulate', 'sunburstR', 'rjson', 'see', 'spacyr', 'vowels'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

RUN R -e "library(devtools); install_github('rezonators/rezonateR', Ncpus = parallel::detectCores())"

USER $NB_USER

# Set environment variables for SRILM
ENV LC_NUMERIC=C \
    PATH=$PATH:/usr/bin/srilm/bin:/usr/bin/srilm/bin/i686-m64
WORKDIR /home/jovyan
