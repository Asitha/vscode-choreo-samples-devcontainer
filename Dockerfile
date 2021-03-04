# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.155.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG BASE_IMG_VARIANT="14"
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${BASE_IMG_VARIANT}

ARG BALLERINA_DEB_URL=""
ARG BALLERINA_VSIX_URL=""
ARG JAVA_SDK_PATH="/usr/lib/ballerina/dependencies/jdk-11.0.8+10-jre/bin"
# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

RUN wget ${BALLERINA_DEB_URL} -O /tmp/ballerina-linux-installer.deb \ 
    && dpkg -i /tmp/ballerina-linux-installer.deb \
    && rm /tmp/ballerina-linux-installer.deb 

RUN wget ${BALLERINA_VSIX_URL} -O /tmp/ballerina.vsix  

RUN ln -s ${JAVA_SDK_PATH}/java /usr/bin/java \
    && echo "PATH=$PATH:${JAVA_SDK_PATH}" >> /home/node/.bashrc \
    && echo "export BALLERINA_SDK_PATH=/usr/lib/ballerina/distributions/ballerina-slalpha2" >> /home/node/.bashrc
