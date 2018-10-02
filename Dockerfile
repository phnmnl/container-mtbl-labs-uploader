FROM docker-registry.phenomenal-h2020.eu/phnmnl/scp-aspera:v3.7.2_cv0.3.10
MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="Allows users to upload data to MetaboLights Labs"
LABEL software.version=0.1.1
LABEL version=0.5
LABEL software="MetaboLights Labs Uploader"

RUN apt-get update -y && \
    apt-get install --no-install-recommends git python python-pip ca-certificates -y && \
    git clone --depth 1 --single-branch -b master https://github.com/ISA-tools/isatools-galaxy /files/galaxy && \
    pip install requests && \
    apt-get purge git ca-certificates python-pip -y && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod a+x /usr/local/bin/runTest1.sh

RUN cp /files/galaxy/tools/mtbls/uploadToMetaboLightsLabs.py /usr/local/bin/uploadToMetaboLightsLabs.py
RUN chmod a+x /usr/local/bin/uploadToMetaboLightsLabs.py

ENTRYPOINT ["uploadToMetaboLightsLabs.py"]
