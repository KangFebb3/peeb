#!/bin/bash
timeout_count=0
loop_count=1
url='https://umk.ac.id/robots.txt'
while true
do
    response=$(curl -s -o /dev/null -w "%{http_code}" -m 5 $url)
    if [ $? -eq 0 ]; then
        timeout_count=0
        echo -e "\e[32mKoneksi Aktif : [$response]\e[0m : [$loop_count] $(date +%T)"
    else
        ((timeout_count++))
        echo -e "\e[33mKoneksi Timeout : [$response]\e[0m $(date +%T)"
    fi
    ((loop_count++))
    if [ $timeout_count -eq 5 ]; then
        echo -e "Enable Airplane Mode"
        su -c 'cmd connectivity airplane-mode enable'
        sleep 8
        echo -e "Disable Airplane Mode"
        su -c 'cmd connectivity airplane-mode disable'
        sleep 8
        timeout_count=0
    fi
    sleep 1
done
