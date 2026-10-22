plugin() {
	genomepy plugin enable blacklist
	genomepy plugin enable bowtie2
	genomepy plugin enable bwa
	genomepy plugin enable star
	genomepy plugin enable minimap2
}

download_genome() {
	local url=$1
	local name=$2
	if [[ "${url}" == *".tar.gz" ]]; then
		local output="./data/${name}.tar.gz"
	elif [[ "${url}" == *".fa.gz" ]]; then
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
