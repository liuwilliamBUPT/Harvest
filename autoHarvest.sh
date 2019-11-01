#!/bin/bash

postRequestFunc(){
    postRequst="curl --cookie ${projectPath}/cookies.txt ${postBaseUrl} -X POST -d ${postBody} | iconv -f gbk -t utf-8"
    return postRequest
}

projectPath=$(cd `dirname $0`; pwd)

echo "---- $(date) ---- " >> ${projectPath}/log.txt
echo "Generate Random Number for Delay" >> ${projectPath}/log.txt

delayTime=$[$RANDOM/150]

echo "Delay ${delayTime} Seconds" >> ${projectPath}/log.txt

sleep $[$RANDOM/150]

response=$(curl --cookie ${projectPath}/cookies.txt "http://jlpzj.net/plugin.php?id=jneggv2" | iconv -f gbk -t utf-8)

hashStr=$(echo ${response} | grep -o "getegg&formhash=[a-zA-Z0-9]\{8\}" | grep -o "formhash=[a-zA-Z0-9]\{8\}")

eggs=$(echo ${response} | grep -o "鸡蛋 : [0-9]*粒" | grep -o "[0-9]*")

money=$(echo ${response} | grep -o "家元： [0-9]* 元" | grep -o "[0-9]*")

getEggs="http://jlpzj.net/plugin.php?id=jneggv2:jneggv2&do=getegg&${hashStr}&infloat=yes&handlekey=joincom&inajax=1&ajaxtarget=fwin_content_joincom"

postBaseUrl="http://jlpzj.net/plugin.php?id=jneggv2:jneggv2&inajax=1"

sellEggs="${hashStr}&changeeggsubmit=yes&handlekey=changeeggsubmit&referer=http%3A%2F%2Fjlpzj.net%2Fplugin.php%3Fid%3Djneggv2&paymount=60"

buyHen="${hashStr}&buychicsubmit=yes&handlekey=editmine&referer=http%3A%2F%2Fjlpzj.net%2Fplugin.php%3Fid%3Djneggv2&paymount=1"

getEggsRequest=$(curl --cookie ${projectPath}/cookies.txt ${getEggs} | iconv -f gbk -t utf-8)
echo -e "---- "$(date)" ---- \n"$getEggsRequest >> ${projectPath}/log.txt

if [[ ${eggs} -gt 60 ]]; then
    postBody=${sellEggs}
    sellEggsRequest=$(postRequestFunc)
    echo -e "----"$(date)" ---- \n"${sellEggRequest} >> ${projectPath}/log.txt
fi

if [[ ${money} -gt 20 ]]; then
    postBody=${buyHen}
    buyHenRequset=$(postRequestFunc)
    echo -e "----"$(date)" ---- \n"${buyHenRequest} >> ${projectPath}/log.txt
fi

