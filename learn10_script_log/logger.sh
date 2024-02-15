#!/bin/bash

LOGPATH="./access-4560-644067.log"
EMAIL_USER="test@localhost.ru"



#echo "X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта"

xip(){
	cat $LOGPATH | awk '{ print $1 }' | sort | uniq -c | sort -r | head -n 10
}


# так, как в явном виде не доно определение урла, то мы считаем, что это адрес после site.ru/URL.php
# .php - потому, что в логе идет обращение к  сайту на php
# если нам нужно вообще "все урлы" то меняем  [[ awk {'print $7'} | cut -d\? -f1| grep php ]] на [[  cut -d' ' -f 7  ]]


yip(){
	cat $LOGPATH | awk {'print $7'} | cut -d\? -f1| grep php | sort | uniq -c| sort -r | head -n 10
}

#echo "все ошибки c момента последнего запуска"
allerror(){
	cat $LOGPATH  | cut -d \" -f 3 | cut -d' ' -f 2 | egrep -v 200\|30
}


#echo "список всех кодов возврата с указанием их кол-ва с момента последнего запуска"

codes(){
	cat $LOGPATH  | grep 'HTTP/1.1"' | awk {'print $9'}  | sort | uniq -c  | sort -r | head -n 10
}



lockfile=/tmp/logger.tmp
# можно сделать проще, не через траппер, а через условие. Может быть не так красиво, но эффективно. 

tmpfile=/tmp/logger.txt 

lasttime=$(cat /tmp/time)

[ -e $LOGPATH ] || exit 5
if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null;
then
    trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT

    lasttime=$( cat $LOGPATH  | cut -d " " -f 4 | tail -n 1 )

    echo "$lasttime" > /tmp/time
    echo "Top X ip: " > $tmpfile
    xip >> $tmpfile
    echo "" >> $tmpfile
    echo "Top Y ip: " >> $tmpfile
    yip >> $tmpfile
    echo "" >> $tmpfile
    echo "All Errors Code: " >> $tmpfile
    allerror >> $tmpfile
    echo "" >> $tmpfile
    echo "Error Codes(count): " >> $tmpfile
    codes >> $tmpfile
   rm -f "$lockfile"


# считает что mailx установлен в centos 
 echo "Распаршенный лог" | mail -s "Распаршенный лог" $email_user -A /tmp/logger.txt


   trap - INT TERM EXIT
else
   echo "Failed to acquire lockfile: $lockfile."
   echo "Held by $(cat $lockfile)"
fi


