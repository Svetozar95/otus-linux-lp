#!/bin/bash



    for i in $(  ls /proc | grep -E '^[0-9]+$' | sort -n); do


	        echo "UID:"  $i
		    echo "TTY:"  $(if [ $( readlink /proc/666/fd/0 | wc -c )  != 0 ]; then echo $(readlink /proc/666/fd/0); else echo -e "?"; fi )


		        echo "STAT:" $(cat /proc/$i/stat | awk '{print $3}')   ##cat /proc/$i/status | grep State | awk '{print $2}'
			    echo "COMMAND:" $(if [ $(cat /proc/$i/cmdline  |  tr '\000' ' ' | wc -c )  != 0 ]; then echo $(cat /proc/$i/cmdline  |  tr '\000' ' '); else   echo $(cat /proc/$i/stat | awk '{print $2}') ; fi )


			        echo " "
				done

