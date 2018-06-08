FROM docker-registry.phenomenal-h2020.eu/phnmnl/scp-aspera:v3.7.2_cv0.3.10
MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="Allows users to upload data to MetaboLights Labs"
LABEL software.version=0.1.0
LABEL version=0.3
LABEL software="MetaboLights Labs Uploader"

ENV REVISION 322e63f7166ba267ced40c5da2c10df200707e91

RUN apt-get -y update && apt-get -y install --no-install-recommends \
                      python-dev python-pip git curl && \
    curl https://bootstrap.pypa.io/get-pip.py | python && pip install -U setuptools && \
    pip install -e git+https://github.com/djcomlab/MetaboLightsLabs-PythonCLI.git@$REVISION#egg=uploadtometabolightslabs && \
    apt-get purge -y python-dev python-pip git && \
    apt-get install -y --no-install-recommends python && \ 
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod a+x /usr/local/bin/runTest1.sh

ENTRYPOINT ["uploadToMetaboLightsLabs.py"]
