FROM ubuntu:18.04
MAINTAINER Darius Felski
LABEL Description="Docker image for IntelliJ IDEA with preinstalled OpenJDK 11" Version="0.1.0"

# upgrade and install some basics first
RUN apt update && apt upgrade -y && apt install -y software-properties-common apt-transport-https wget

# add vscode repository
#RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
#RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# update new added repository
#RUN find /etc/apt/sources.list.d -type f -name '*.list' -exec apt update -o Dir::Etc::sourcelist="{}" ';'

# add Zulu-OpenJDK 11 package
RUN wget -q https://cdn.azul.com/zulu/bin/zulu11.2.3-jdk11.0.1-linux_amd64.deb
RUN apt install -y ./zulu11.2.3-jdk11.0.1-linux_amd64.deb

# get IntelliJ IDEA
RUN wget -q https://download.jetbrains.com/idea/ideaIC-2018.3-no-jdk.tar.gz
RUN tar xf ideaIC-2018.3-no-jdk.tar.gz -C /opt/

# install Maven
RUN apt install -y maven

CMD ["/opt/idea-IC-183.4284.148/bin/idea.sh"]
