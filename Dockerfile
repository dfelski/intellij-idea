FROM debian:buster

MAINTAINER Darius Felski
LABEL Description="Docker image for IntelliJ IDEA with preinstalled OpenJDK 11"

ARG JDK_VERSION=11.0.5+10-2
ARG INTELLIJ_VERSION=2019.3.1
ARG MAVEN_VERSION=3.6.3
ARG GRADLE_VERSION=6.0.1

RUN apt update \
    && echo "install some basics first" \
    && apt install -y software-properties-common apt-transport-https wget unzip libfontconfig1 git

RUN echo "install AdoptOpenJDK 11" \
    && wget -q https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/pool/main/a/adoptopenjdk-11-hotspot/adoptopenjdk-11-hotspot_${JDK_VERSION}_amd64.deb -O /tmp/adoptopenjdk.deb \
    && apt install -y /tmp/adoptopenjdk.deb \
    && rm -rf /tmp/*

RUN echo "install maven & gradle" \
    && wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -O /tmp/gradle.zip \
    && unzip -d /opt/ /tmp/gradle.zip \
    \
    && echo "install maven" \
    && wget -q ftp://ftp.fu-berlin.de/unix/www/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip -O /tmp/maven.zip \
    && unzip -d /opt/ /tmp/maven.zip \
    && rm -rf /tmp/*

RUN echo "install IntelliJ IDEA" \
    && wget -q https://download.jetbrains.com/idea/ideaIC-${INTELLIJ_VERSION}-no-jbr.tar.gz -O /tmp/idea.tar.gz \
    && mkdir -p /opt/idea \
    && tar zxvf /tmp/idea.tar.gz --strip-components=1 -C /opt/idea \
    && rm -rf /tmp/*

ENV PATH="/opt/gradle-${GRADLE_VERSION}/bin:${PATH}"
ENV PATH="/opt/apache-maven-${MAVEN_VERSION}/bin:${PATH}"
ENV LC_CTYPE en_US.UTF-8

CMD ["/opt/idea/bin/idea.sh"]
