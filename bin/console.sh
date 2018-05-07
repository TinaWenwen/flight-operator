#!/bin/sh

TODAY=$(date "+%Y-%m-%d")
echo -e '\n\ntail -f logs/catalina/catalina.'${TODAY}'.log\n\n'
function pause(){
        read -n 1 -p "$*" INP
        if [ $INP != '' ] ; then
                echo -ne '\b \n'
        fi
}
pause 'Press any key to continue...'
tail -f logs/catalina/catalina.${TODAY}.log

