FROM alpine:latest as builder
WORKDIR /app
RUN apk add --no-cache \
    wget \
    unzip
ARG ARCHI_VERSION=4.7.0-ea2
ARG COLLAB_VERSION=0.5.4.202002281020
RUN wget -O archi.tgz -q https://www.archimatetool.com/downloads/beta/Archi-Linux64-${ARCHI_VERSION}.tgz && \
    wget -O collab.archiplugin -q https://www.archimatetool.com/downloads/plugins/org.archicontribs.modelrepository_${COLLAB_VERSION}.archiplugin && \
    tar xf archi.tgz && \
    unzip collab.archiplugin -d Archi/plugins && \
    rm archi.tgz collab.archiplugin

FROM ubuntu:latest
WORKDIR /opt
COPY --from=builder /app/Archi /opt/Archi
COPY entrypoint.sh /entrypoint.sh 
RUN chmod +x /entrypoint.sh

VOLUME /model
VOLUME /output

RUN apt-get update && apt-get install -y xvfb libgtk-3-0 && rm -rf /var/lib/apt/lists/*

ENV DISPLAY :99

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-h"]
# --html.createReport /output/report --loadModel /model/model.archimate
# --html.createReport /output/report --modelrepository.loadModel /model/