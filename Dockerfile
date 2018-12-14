FROM rocker/verse:3.5.1
RUN sudo apt-get install -f -y libmagick++-dev
RUN R -e "install.packages('R.matlab')"
RUN wget https://github.com/ljcolling/RRR-manuscript/raw/master/ReplicationProjectTools_0.0.0.9000.tar.gz
RUN R CMD INSTALL ReplicationProjectTools_0.0.0.9000.tar.gz 
RUN rm ReplicationProjectTools_0.0.0.9000.tar.gz
RUN R -e "install.packages('reticulate')"
RUN R -e "install.packages('forestplot')"
RUN R -e "install.packages('lme4')"

# Install python for processing matlab files
# and for extracting citation counts
RUN apt-get update && apt-get -y install \
     python-virtualenv \
     python-pip && \
     pip install scipy
RUN apt-get install -y libpython-dev
RUN apt-get install -y libpython3-dev

# Install papaja 

RUN wget https://github.com/crsh/papaja/archive/v0.1.0.9842.tar.gz
RUN R CMD INSTALL v0.1.0.9842.tar.gz 
RUN rm v0.1.0.9842.tar.gz 

# Fix latex stuff
RUN tlmgr update --self
RUN tlmgr install apa6 booktabs caption csquotes endfloat environ etoolbox fancyhdr fancyvrb framed lineno microtype mptopdf ms parskip pgf sttools threeparttable threeparttablex trimspaces txfonts upquote url was xcolor 
RUN tlmgr install multirow
RUN tlmgr install float

# Install stuff for running in parallel 
RUN wget https://github.com/HenrikBengtsson/globals/archive/0.12.4.tar.gz
RUN R CMD INSTALL 0.12.4.tar.gz
RUN rm 0.12.4.tar.gz
RUN R -e "devtools::install_github('DavisVaughan/furrr')"

RUN pip install MechanicalSoup
