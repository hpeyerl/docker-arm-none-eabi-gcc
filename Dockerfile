FROM ubuntu:18.04
LABEL maintainer="Herb Peyerl <herb.peyerl@kinetyx.tech>"
LABEL Description="Image for building and debugging Nordic NRF and arm-embedded projects from git"
WORKDIR /work

ADD . /work

# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
# Development files
      build-essential \
      git \
      bzip2 \
      unzip \
      python3-pip \
      wget && \
    apt-get clean
RUN python3 -m pip install --upgrade pip
RUN pip3 install nrfutil
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj
RUN wget -q https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-13-0/nRF-Command-Line-Tools_10_13_0_Linux64.zip
RUN unzip nRF-Command-Line-Tools_10_13_0_Linux64.zip
RUN tar xvf nRF-Command-Line-Tools_10_13_0_Linux64/nRF-Command-Line-Tools_10_13_0_Linux-amd64.tar.gz
RUN dpkg -i nRF-Command-Line-Tools_10_13_0_Linux-amd64.deb
RUN rm -rf nRF-Command-Line-Tools_10_13_0_Linux-amd64.deb JLink_Linux_V750a_x86_64.deb JLink_Linux_V750a_x86_64.tgz
RUN rm -fr nRF-Command-Line-Tools_10_13_0_Linux64.zip nRF-Command-Line-Tools_10_13_0_Linux64 nRF-Command-Line-Tools_10_13_0.tar

ENV PATH "/work/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"
