#!/bin/bash

source /etc/profile

cd /root/apprtc

npm install 

easy_install -U requests

apt install -y default-jre

grunt build

sed -i 's|wss://|ws://|' src/app_engine/apprtc.py

sed -i 's|https://|http://|' src/app_engine/apprtc.py

machine_ip=$(ip add | grep inet | grep eth0 | awk '{print $2}' | sed  's|/.*$||')

sed -i 's|apprtc-ws.webrtc.org:443|'${machine_ip}':8089|' src/app_engine/constants.py

#dev_appserver.py --host=0.0.0.0 ./out/app_engine
