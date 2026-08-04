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
    if [[ "${url}" == *".tar.gz" ]]
    then
        local output="./data/${name}.tar.gz"
    elif [[ "${url}" == *".fa.gz" ]]
    then
        local output="./data/${name}.fa.gz"
    else
        echo "Error: unknow suffix"
        exit 1
    fi
    wget -c "${url}" -O ${output}
    plugin
    genomepy install \
        -p local \
        -l ${name} \
        ${output}
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

download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/hs1/bigZips/hs1.fa.gz" "hs1"
download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.chromFa.tar.gz" "GRCh38"
# download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/chromFa.tar.gz" "GRCh37"
download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/mm39/bigZips/mm39.chromFa.tar.gz" "GRCm39"
# download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/mm10/bigZips/chromFa.tar.gz" "GRCm38"
# download_genome "https://hgdownload.soe.ucsc.edu/goldenPath/mm9/bigZips/chromFa.tar.gz" "GRCm37"
