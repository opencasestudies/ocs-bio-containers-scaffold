FROM rocker/tidyverse:4.5.3@sha256:913d87bd9b81480b97bd4fc18e619e71d12b0a034bc80bb841830ac10278fd1a

ENV DEBIAN_FRONTEND=noninteractive

# Install Java + minimal system libs needed for R packages
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    openjdk-11-jdk \
    libpng-dev \
    libicu-dev \
    libpcre2-dev \
 && R CMD javareconf \
 && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN install2.r --error --deps TRUE \
    bubbleHeatmap \
    ggnetwork \
    ggpubr \
    gt \
    here \
    rJava \
    tabulapdf \
 && rm -rf /tmp/downloaded_packages \
 && rm -rf /root/.cache
