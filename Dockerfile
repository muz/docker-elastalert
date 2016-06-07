FROM python:2.7

MAINTAINER Muz Ali "docker-elastalert@mustaqila.li"

ENV ELASTALERT_DIR /opt/elastalert

# Deps
RUN apt-get update && apt-get install -y \
  curl \
  gcc \
  python-dev \
  musl-dev \
  unzip

# App
RUN curl -L -o elastalert.zip https://github.com/Yelp/elastalert/archive/v0.0.83.zip && \
  unzip elastalert.zip && \
  mv elastalert-0.0.83 ${ELASTALERT_DIR} && \
  rm elastalert.zip

WORKDIR ${ELASTALERT_DIR}

RUN pip install setuptools && \
  pip install -r requirements.txt && \
  python ./setup.py install

RUN mkdir -p /etc/elastalert

VOLUME ["/etc/elastalert"]

COPY ./elastalert.sh elastalert.sh

RUN chmod a+x elastalert.sh

ENTRYPOINT ["/opt/elastalert/elastalert.sh"]
CMD ["python", "-m", "elastalert.elastalert", "--config", "/etc/elastalert/config.yaml", "--verbose"]
