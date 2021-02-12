# continuumio/miniconda3:4.8.2
FROM continuumio/miniconda3@sha256:456e3196bf3ffb13fee7c9216db4b18b5e6f4d37090b31df3e0309926e98cfe2

LABEL authors="sangram@lifebit.ai" \
      description="Docker image containing dependencies for lifebit-ai/seqarray-nf"

RUN apt-get update && \
  apt-get install procps libxt-dev -y && \
  conda install bioconductor-seqarray=1.26.0 r-digest -c r -c bioconda -y && \
  conda clean -a

# Copy additonal scripts
RUN mkdir -p /opt/bin
COPY ./ /opt/bin
RUN chmod +x /opt/bin/*
ENV PATH="$PATH:/opt/bin/"
