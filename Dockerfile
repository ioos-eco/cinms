# Container image that runs your code  
FROM rocker/geospatial:latest

# install extra R packages 
RUN install2.r --error \
  fs \
  glue \
  here \
  lubridate \
  rerddap \
  tidyverse \
  devtools
  
RUN installGithub.r marinebon/nms4r

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
