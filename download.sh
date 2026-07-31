#!/bin/bash

plugin() {
    genomepy plugin enable blacklist
    genomepy plugin enable bowtie2
    genomepy plugin enable bwa
    genomepy plugin enable star
}

download_genome() {
    local url=$1
    local name=$2
    if [[ ! -f ./data/${name}.tar.gz ]]
    then
        wget "${url}" -O ./data/${name}.tar.gz
    fi
    plugin
    genomepy install \
        -p local \
        -l ${name} \
        ./data/${name}.tar.gz
}

download_geo() {
    local gse=$1
    geofetch -i ${gse} \
        --processed \
        --data-source all \
        --geo-folder ./data \
        -m ./data
}

mkdir -p ./data

# download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/chromFa.tar.gz" "GRCm38"
# download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/mm9/bigZips/chromFa.tar.gz" "GRCm37"
# download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/chromFa.tar.gz" "GRCh37"
