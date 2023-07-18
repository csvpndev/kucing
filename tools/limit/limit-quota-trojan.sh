#!/bin/bash
data=( `ls /etc/cobek/limit/trojan/quota`);
for user in "${data[@]}"
do
vlimit=$(cat /etc/cobek/limit/trojan/quota/$user)
vasli=$(cat /etc/cobek/trojan/$user)
if [[ $vasli -gt $vlimit ]]; then
sed -i "/$user/d" /etc/xray/trojan*
rm /etc/cobek/trojan/$user
rm /etc/cobek/cache/*/$user
rm /etc/cobek/limit/trojan/quota/$user
nais=3
else
echo > /dev/null
fi
sleep 0.1
done
if [[ $nais -gt 1 ]]; then
systemctl restart trojan-ws
systemctl restart trojan-grpc
else
echo > /dev/null
fi