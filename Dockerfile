FROM jetbrainsinfra/xvfb-java

WORKDIR /opt
RUN wget -q https://www.archimatetool.com/downloads/4.4.0/Archi-Linux64-4.4.0.tgz && \
    wget -q https://www.archimatetool.com/downloads/plugins/org.archicontribs.modelrepository_0.5.1.201904031126.zip && \
    tar xf Archi-Linux64-4.4.0.tgz && \
    unzip org.archicontribs.modelrepository_0.5.1.201904031126.zip -d Archi/plugins && \
    rm Archi-Linux64-4.4.0.tgz org.archicontribs.modelrepository_0.5.1.201904031126.zip

COPY entrypoint.sh /entrypoint.sh 
RUN chmod +x /entrypoint.sh

VOLUME /model
VOLUME /output

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-h"]
# --html.createReport /output/report --loadModel /model/model.archimate
# --html.createReport /output/report --modelrepository.loadModel /model/