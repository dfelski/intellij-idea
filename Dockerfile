FROM ubuntu:18.04
MAINTAINER Darius Felski
LABEL Description="Docker image for IntelliJ IDEA with preinstalled OpenJDK 11"

RUN apt update \
    && echo "install some basics first" \
    && apt install -y software-properties-common apt-transport-https wget unzip libfontconfig1

RUN echo "install AdoptOpenJDK 11" \
    && wget -q https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/pool/main/a/adoptopenjdk-11-hotspot/adoptopenjdk-11-hotspot_11.0.4+11-2_amd64.deb \
    && apt install -y ./adoptopenjdk-11-hotspot_11.0.4+11-2_amd64.deb \
    && rm ./adoptopenjdk-11-hotspot_11.0.4+11-2_amd64.deb

RUN echo "install maven and gradle" \
    && wget -q https://services.gradle.org/distributions/gradle-5.6-bin.zip -O /tmp/gradle.zip \
    && mkdir /opt/gradle \
    && unzip -d /opt/gradle /tmp/gradle.zip \
    \
    && rm -rf /tmp/* \
    \
    && echo "install git, maven and groovy" \
    && apt install -y git maven groovy

RUN echo "install IntelliJ IDEA" \
    && wget -q https://download.jetbrains.com/idea/ideaIC-2019.2-no-jbr.tar.gz -O /tmp/idea.tar.gz \
    && mkdir -p /opt/idea \
    && tar zxvf /tmp/idea.tar.gz --strip-components=1 -C /opt/idea

ENV PATH="/opt/gradle/gradle-5.6/bin:${PATH}"
ENV LC_CTYPE en_US.UTF-8

CMD ["/opt/idea/bin/idea.sh"]
