FROM docker-registry.phenomenal-h2020.eu/phnmnl/scp-aspera:v3.7.2_cv0.3.10
MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="Allows users to upload data to MetaboLights Labs"
LABEL software.version=0.1.0
LABEL version=0.4
LABEL software="MetaboLights Labs Uploader"

RUN apk add --no-cache --virtual git-deps git openssh \
    && git clone --depth 1 --single-branch -b develop https://github.com/ISA-tools/isatools-galaxy /files/galaxy \
    && apk del git-deps \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* /var/tmp/*

RUN apt-get -y update && apt-get -y install --no-install-recommends git && \
    git clone --depth 1 --single-branch -b develop https://github.com/ISA-tools/isatools-galaxy /files/galaxy \
    apt-get purge -y git && \
    apt-get install -y --no-install-recommends python && \ 
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod a+x /usr/local/bin/runTest1.sh

RUN cp /files/galaxy/tools/mtbls/uploadToMetaboLightsLabs.py /usr/local/bin/uploadToMetaboLightsLabs.py
RUN chmod a+x /usr/local/bin/uploadToMetaboLightsLabs.py

ENTRYPOINT ["uploadToMetaboLightsLabs.py"]
