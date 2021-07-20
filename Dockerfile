FROM rocker/binder:4.0.3
USER root
RUN wget https://github.com/vinay-swamy/BIOF076-Visualization-with-R/raw/master/DESCRIPTION && R -e "devtools::install_deps()"

