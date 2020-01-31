#!/bin/bash

postRequest(){
    echo -e "---- "$(date)" ----" >> ${projectPath}/log.txt
    curl --cookie ${projectPath}/cookies.txt ${postBaseUrl} -X POST -d ${postBody} | iconv -f gbk -t utf-8 >> ${projectPath}/log.txt
}

projectPath=$(cd `dirname $0`; pwd)

source config

if [ -z ${secret_key} ]; then
	secret_key=$(cat ${projectPath}/secret_key)
fi

if [ -z ${qqbot_host} ]; then
    qqbot_host=$(cat ${projectPath}/qqbot_host)
fi

echo "---- $(date) ---- " >> ${projectPath}/log.txt
echo "Generate Random Number for Delay" >> ${projectPath}/log.txt

delayTime=$[$RANDOM/150]

echo "Delay ${delayTime} Seconds" >> ${projectPath}/log.txt

sleep $delayTime

response=$(curl --cookie ${projectPath}/cookies.txt "http://jlpzj.net/plugin.php?id=jneggv2" | iconv -f gbk -t utf-8)
cookies_expired=$(echo ${response} | grep -o "您的所在用户组没权限可进入。")

if [ "${secret_key}" ]; then
	if [ "${cookies_expired}" ]; then
		curl "https://sc.ftqq.com/${secret_key}.send?text=纪录片之家cookies过期。"
		exit
	fi
fi

if [ "${qqbot_host}" ]; then
    if [ "${cookies_expired}" ]; then
        curl "http://{qqbot_host}/send_private_msg?access_token=${token}&user_id=${qq}&message=Cookies过期"
        exit
    fi
fi

hashStr=$(echo ${response} | grep -o "getegg&formhash=[a-zA-Z0-9]\{8\}" | grep -o "formhash=[a-zA-Z0-9]\{8\}")

if [[ $(date "+%H") -eq 12 ]]; then
    postBaseUrl="http://jlpzj.net/plugin.php?id=dsu_paulsign:sign&operation=qiandao&infloat=1&inajax=1"
    postBody="${hashStr}&qdxq=yl&qdmode=3&todaysay=&fastreply=0"
    postRequest
fi

getEggs="http://jlpzj.net/plugin.php?id=jneggv2:jneggv2&do=getegg&${hashStr}&infloat=yes&handlekey=joincom&inajax=1&ajaxtarget=fwin_content_joincom"

getEggsRequest=$(curl --cookie ${projectPath}/cookies.txt ${getEggs} | iconv -f gbk -t utf-8)
echo -e "---- "$(date)" ---- \n"$getEggsRequest >> ${projectPath}/log.txt

response=$(curl --cookie ${projectPath}/cookies.txt "http://jlpzj.net/plugin.php?id=jneggv2" | iconv -f gbk -t utf-8)
hashStr=$(echo ${response} | grep -o "getegg&formhash=[a-zA-Z0-9]\{8\}" | grep -o "formhash=[a-zA-Z0-9]\{8\}")
eggs=$(echo ${response} | grep -o "鸡蛋 : [0-9]*粒" | grep -o "[0-9]*")
postBaseUrl="http://jlpzj.net/plugin.php?id=jneggv2:jneggv2&inajax=1"

remainderE=$((${eggs}%3))
sellNum=$((${eggs}-${remainderE}))
sellEggs="${hashStr}&changeeggsubmit=yes&handlekey=changeeggsubmit&referer=http%3A%2F%2Fjlpzj.net%2Fplugin.php%3Fid%3Djneggv2&paymount=${sellNum}"

if [[ ${sellNum} -gt 0 ]]; then
    postBody=${sellEggs}
    postRequest
fi

response=$(curl --cookie ${projectPath}/cookies.txt "http://jlpzj.net/plugin.php?id=jneggv2" | iconv -f gbk -t utf-8)
hashStr=$(echo ${response} | grep -o "getegg&formhash=[a-zA-Z0-9]\{8\}" | grep -o "formhash=[a-zA-Z0-9]\{8\}")
money=$(echo ${response} | grep -o "家元: [0-9]* 元" | grep -o "[0-9]*")

remainderM=$((${money}%20))
buyNum=$(((${money}-${remainderM})/20))
buyHen="${hashStr}&buychicsubmit=yes&handlekey=editmine&referer=http%3A%2F%2Fjlpzj.net%2Fplugin.php%3Fid%3Djneggv2&paymount=${buyNum}"

if [[ ${buyNum} -gt 0 ]]; then
    postBody=${buyHen}
    postRequest
fi

echo "---- "$(date)" ----" >> ${projectPath}/log.txt
echo "Eggs: ${eggs} Money: ${money}" >> ${projectPath}/log.txt


