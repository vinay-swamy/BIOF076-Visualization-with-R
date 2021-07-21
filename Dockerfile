FROM rocker/geospatial:4.0.3
USER root
ENV RSTUDIO_VERSION 1.2.5042
RUN /rocker_scripts/install_rstudio.sh

#ENV NB_USER=jovyan

RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_binder.sh

CMD jupyter notebook --ip 0.0.0.0

USER ${NB_USER}

WORKDIR /home/${NB_USER}
RUN wget https://github.com/vinay-swamy/BIOF076-Visualization-with-R/raw/master/DESCRIPTION && R -e "devtools::install_deps()"

