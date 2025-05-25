#!/bin/bash

/usr/local/bin/print_logo

# Clean tmp

find /tmp -type f -mtime +7 -delete 
find /tmp/ -type d -mtime +7 -exec \rm -fr {} \; &>/dev/null


check_port() {
    local port=$1
    local retries=30
    local wait_time=2
    local attempt=1

    while (( attempt <= retries )); do
        if netstat -lNnp | grep ":$port" &>/dev/null; then
            echo " started "
            return 0
        else
            echo -ne "."
            if (( attempt < retries )); then
                sleep $wait_time
            fi
        fi
        ((attempt++))
    done

    echo "not started"
    return 1
}


# Start Apache/PHP server
echo "Starting Apache/PHP/PGSQL Server"
/etc/init.d/apache2 restart &>/dev/null
/etc/init.d/postgresql restart

# Create symbolic link for Apache error log if it doesn't exist
if [ ! -e "/var/www/html/HerikaServer/log/apache_error.log" ]; then
  mkdir -p /var/www/html/HerikaServer/log/
  ln -sf /var/log/apache2/error.log /var/www/html/HerikaServer/log/apache_error.log
fi

if [ -f  "/home/dwemer/minime-t5/start.sh" ]
then
	echo -ne  "Starting Minime-T5/TXT2VEC service "
	su dwemer -c /home/dwemer/minime-t5/start.sh
	check_port 8082
else
	echo "Skipping Minime-T5/TXT2VEC service (not enabled)"
	L_MINIME=1
fi

if [ -f  "/home/dwemer/mimic3/start.sh" ]
then
	echo -ne  "Starting Mimic3 TTS "
	su dwemer -c /home/dwemer/mimic3/start.sh
	check_port 59125
else
	echo "Skipping Mimic3 TTS (not enabled)"
	L_MIMIC=1

fi

if [ -f  "/home/dwemer/MeloTTS/start.sh" ]
then
	echo -ne  "Starting MeloTTS "
	su dwemer -c /home/dwemer/MeloTTS/start.sh
	check_port 8084
else
	echo "Skipping MeloTTS (not enabled)"
	L_MELOTTS=1

fi


if [ -f  "/home/dwemer/remote-faster-whisper/config.yaml" ]
then
	echo -ne  "Starting LocalWhisper Server "
	su dwemer -c "/home/dwemer/remote-faster-whisper/start.sh"
	check_port 9876
else
	L_WHISPER=1
	echo  "Skipping LocalWhisper Server (not enabled)"
fi

if [ -f  "/home/dwemer/xtts-api-server/start.sh" ]
then
	echo -ne  "Starting CHIM XTTS server"
	su dwemer -c "/home/dwemer/xtts-api-server/start.sh"
	check_port 8020
else
	echo  "Skipping CHIM XTTS server (not enabled)"
	L_XTTSV2=1

fi


ipaddress=$(/usr/local/bin/get_ip)

cat << EOF
=======================================
Download AIAgent.ini under Server Actions!
AIAgent.ini Network Settings:
----------------------------
SERVER=$ipaddress
PORT=8081
PATH=/HerikaServer/comm.php
POLINT=1
----------------------------
DwemerDistro Local IP Address: $ipaddress
CHIM WebServer URL: http://$ipaddress:8081

Running Components:
EOF

if [ -z "$L_MINIME" ]; then
	echo Minime-T5/TXT2VEC API: http://$ipaddress:8082
fi

if [ -z "$L_WHISPER" ]; then
	echo LocalWhisper API: http://$ipaddress:9876
fi

if [ -z "$L_XTTSV2" ]; then
	echo CHIM XTTS API: http://$ipaddress:8020
fi

if [ -z "$L_MIMIC" ]; then
	echo Mimic3 API: http://$ipaddress:59125
fi

if [ -z "$L_MELOTTS" ]; then
	echo MelotTTS API: http://$ipaddress:8084
fi

explorer.exe http://$ipaddress:8081/HerikaServer/ui/index.php &>/dev/null&

echo "Press Enter to shutdown DwemerDistro"
read

killall -15 -u dwemer

/etc/init.d/apache2 stop
/etc/init.d/postgresql stop

echo "DwemerDistro has stopped running"

