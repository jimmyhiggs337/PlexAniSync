FROM python:3.9 AS builder

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
# install dependencies to the local user directory (eg. /root/.local)
RUN pip install --user --no-warn-script-location -r requirements.txt

FROM python:3.9-slim

WORKDIR /plexanisync

#VOLUME /config

# copy only the dependencies installation from the 1st stage image
COPY --from=builder /root/.local /root/.local
RUN chmod -R a+rX /root
# update PATH environment variable
ENV PATH=/root/.local:$PATH
ENV PYTHONPATH=/root/.local/lib/python3.9/site-packages

ENV SETTINGS_FILE='/config/settings.ini' 

ENV INTERVAL=3600

COPY Docker/PlexAniSync/run/. .
# copy code itself from context to image
COPY . .

#LABEL org.opencontainers.image.documentation=https://github.com/RickDB/PlexAniSync/blob/master/Docker/PlexAniSync/README.md

CMD ["/plexanisync/runsync.sh"]