#!/bin/bash
echo "---- "$(date)" ---- " >> /root/jlpzj/log.txt
echo "Generate Random Number" >> /root/jlpzj/log.txt

sleeptime=$[$RANDOM/150]

echo "Sleep "$sleeptime" Seconds" >> /root/jlpzj/log.txt

sleep $[$RANDOM/150]

response=$(curl --cookie /root/jlpzj/cookies.txt "http://jlpzj.net/plugin.php?id=jneggv2")

str=$(echo $response | grep -o "getegg&formhash=[a-zA-Z0-9]\{8\}")

url="http://jlpzj.net/plugin.php?id=jneggv2:jneggv2&do="$str"&infloat=yes&handlekey=joincom&inajax=1&ajaxtarget=fwin_content_joincom"

runlog=$(curl --cookie /root/jlpzj/cookies.txt $url |iconv -f gbk -t utf-8)

echo -e "---- "$(date)" ---- \n"$runlog >> /root/jlpzj/log.txt 
