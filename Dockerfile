FROM ubuntu:18.04
MAINTAINER Darius Felski
LABEL Description="Docker image for IntelliJ IDEA with preinstalled OpenJDK 11" Version="0.2.0"

# upgrade and install some basics first
RUN apt update && apt upgrade -y && apt install -y software-properties-common apt-transport-https wget unzip

# install Zulu OpenJDK 11 package
RUN wget -q https://cdn.azul.com/zulu/bin/zulu11.2.3-jdk11.0.1-linux_amd64.deb
RUN apt install -y ./zulu11.2.3-jdk11.0.1-linux_amd64.deb
RUN rm ./zulu11.2.3-jdk11.0.1-linux_amd64.deb

# install IntelliJ IDEA
RUN wget -q https://download.jetbrains.com/idea/ideaIC-2018.3.1-no-jdk.tar.gz
RUN tar xf ideaIC-2018.3.1-no-jdk.tar.gz -C /opt/ && rm ./ideaIC-2018.3.1-no-jdk.tar.gz

# install Gradle
RUN wget -q https://services.gradle.org/distributions/gradle-5.0-bin.zip
RUN mkdir /opt/gradle && unzip -d /opt/gradle gradle-5.0-bin.zip && rm gradle-5.0-bin.zip
ENV PATH="/opt/gradle/gradle-5.0/bin:${PATH}"

# install Git and Maven
RUN apt install -y git maven

CMD ["/opt/idea-IC-183.4284.148/bin/idea.sh"]
