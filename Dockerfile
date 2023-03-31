FROM mcr.microsoft.com/vscode/devcontainers/miniconda:0-3

RUN conda install -c conda-forge openmc=0.13.3
RUN pip install openmc_data_downloader

RUN openmc_data_downloader -d nuclear_data -l ENDFB-8.0-NNDC TENDL-2019 -p neutron photon -e all -i H3 --no-overwrite

RUN pip install openmc_data && \
    mkdir -p /nuclear_data && \
    download_nndc_chain -d nuclear_data -r b8.0

ENV OPENMC_CROSS_SECTIONS=/nuclear_data/cross_sections.xml
ENV OPENMC_CHAIN_FILE=/nuclear_data/chain-nndc-b8.0.xml
