#!/usr/bin/env bash 

# argument 1st could contains device address in case more than one devices is connected
adb=adb
if [ $# -eq 1 ];then
    adb="adb -s ${1}"
fi


svc="$adb shell svc"
while true;
do 
    ScreenStatus=$($adb shell dumpsys power | grep 'Display Power' | cut -d'=' -f2)
    case $ScreenStatus in
    'OFF') 
        $svc data disable
        $svc wifi disable
        ;;
    'ON') 
        $svc data enable
        $svc wifi enable
        ;;
    *) echo 'report issue'
    esac
    sleep 3
done