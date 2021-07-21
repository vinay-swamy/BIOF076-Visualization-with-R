FROM vinayswamy/biof076-docker:0.3
LABEL maintainer='Unknown'
ENV NB_USER=rstudio
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
