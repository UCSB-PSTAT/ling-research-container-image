FROM registry.cloud.college.ucsb.edu/ucsb/rstudio-base:latest

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

RUN mamba install -y -c conda-forge -c bioconda \
    gensim \
    keras \
    morfessor \
    nltk \
    ptable \
    pytest \
    pytorch \
    r-bayestestr \
    r-ca \
    r-cca \
    r-cowplot \
    r-devtools \
    r-dirichletreg \
    r-doparallel \
    r-ellipse \
    r-factoextra \
    r-factominer \
    r-ggalluvial \
    r-ggally \
    r-ggbreak \
    r-ggfittext \
    r-ggforce \
    r-ggmosaic \
    r-ggpattern \
    r-ggplot2 \
    r-ggrepel \
    r-ggthemes \
    r-ggvenndiagram \
    r-ggwordcloud \
    r-keras \
    r-lmertest \
    r-mclust \
    r-ordinal \
    r-plotly \
    r-pvclust \
    r-reticulate \
    r-rjson \
    r-see \
    r-spacyr \
    r-sunburstr \
    r-vowels \
    scikit-learn \
    spacy \
    tensorflow-cpu \
    textgrid \
    tgt \
    torchaudio \
    torchvision \
    && mamba clean -afy
    
# Because some packages are special:
RUN pip install arpa

RUN R -e "install.packages('glossr'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())" &&\
    R -e "library(devtools); pak::pak('rezonators/rezonateR', Ncpus = parallel::detectCores())"

USER $NB_USER

# Set environment variables for SRILM
ENV LC_NUMERIC=C \
    PATH=$PATH:/usr/bin/srilm/bin:/usr/bin/srilm/bin/i686-m64
WORKDIR /home/jovyan
