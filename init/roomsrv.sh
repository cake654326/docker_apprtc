
#!/bin/bash

set -e

init_roomserver(){

	echo "init room server ....."

	. /etc/profile

	cd /root/apprtc

	apt install -y default-jre

	npm install grunt-closurecompiler

	npm install 

	easy_install -U requests

	#	sed -i 's|wss://|ws://|' src/app_engine/apprtc.py
	#	sed -i 's|https://|http://|' src/app_engine/apprtc.py

	machine_ip=$(ip add | grep inet | grep eth0 | awk '{print $2}' | sed  's|/.*$||')

	sed -i 's|apprtc-ws.webrtc.org:443|'${machine_ip}':8089|' src/app_engine/constants.py
	sed -i 's|apprtc-ws-2.webrtc.org:443|'${machine_ip}':8089|' src/app_engine/constants.py

	grunt build

	cat<<EOF > /root/.appcfg_nag
opt_in: false
timestamp: 0.0
EOF

}

init_roomserver
