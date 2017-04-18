#!/bin/bash

source /etc/profile

cd /root/apprtc

npm install 

easy_install -U requests

apt install -y default-jre


sed -i 's|wss://|ws://|' src/app_engine/apprtc.py

sed -i 's|https://|http://|' src/app_engine/apprtc.py

machine_ip=$(ip add | grep inet | grep eth0 | awk '{print $2}' | sed  's|/.*$||')

sed -i 's|apprtc-ws.webrtc.org:443|'${machine_ip}':8089|' src/app_engine/constants.py
sed -i 's|apprtc-ws-2.webrtc.org:443|'${machine_ip}':8089|' src/app_engine/constants.py

grunt build

nohup dev_appserver.py --host=${machine_ip} ./out/app_engine &
