

FROM mcr.microsoft.com/vscode/devcontainers/miniconda:0-3

RUN sudo apt-get -y update

RUN sudo apt install -y libgl1-mesa-glx

RUN conda install -c conda-forge openmc=0.13.3
RUN pip install openmc_data_downloader
RUN pip install vtk

RUN sudo mkdir -m 777 -p /usr/nuclear_data

RUN openmc_data_downloader -d /usr/nuclear_data -l ENDFB-8.0-NNDC TENDL-2019 -p neutron photon -e all -i H3 --no-overwrite

RUN pip install openmc_data && \
    download_nndc_chain -d /usr/nuclear_data -r b8.0

ENV OPENMC_CROSS_SECTIONS=/usr/nuclear_data/cross_sections.xml
ENV OPENMC_CHAIN_FILE=/usr/nuclear_data/chain-nndc-b8.0.xml
