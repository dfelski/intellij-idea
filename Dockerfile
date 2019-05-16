FROM ubuntu:18.04
MAINTAINER Darius Felski
LABEL Description="Docker image for IntelliJ IDEA with preinstalled OpenJDK 11" Version="0.5.0"

RUN apt update \
    && echo "install some basics first" \
    && apt install -y software-properties-common apt-transport-https wget unzip

RUN echo "install Zulu OpenJDK 11" \
    && wget -q https://cdn.azul.com/zulu/bin/zulu11.31.11-ca-jdk11.0.3-linux_amd64.deb \
    && apt install -y ./zulu11.31.11-ca-jdk11.0.3-linux_amd64.deb \
    && rm ./zulu11.31.11-ca-jdk11.0.3-linux_amd64.deb

RUN echo "install maven and gradle" \
    && wget -q https://services.gradle.org/distributions/gradle-5.4.1-bin.zip -O /tmp/gradle.zip \
    && mkdir /opt/gradle \
    && unzip -d /opt/gradle /tmp/gradle.zip \
    \
    && rm -rf /tmp/* \
    \
    && echo "install git, maven and groovy" \
    && apt install -y git maven groovy

RUN echo "install IntelliJ IDEA" \
    && wget -q https://download.jetbrains.com/idea/ideaIC-2019.1.2-no-jbr.tar.gz -O /tmp/idea.tar.gz \
    && mkdir -p /opt/idea \
    && tar zxvf /tmp/idea.tar.gz --strip-components=1 -C /opt/idea

ENV PATH="/opt/gradle/gradle-5.4.1/bin:${PATH}"

CMD ["/opt/idea/bin/idea.sh"]
