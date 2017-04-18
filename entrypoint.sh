
#!/bin/bash

init_collider(){

	mkdir -p /root/collider_root/src

	ln -s /root/apprtc/src/collider/collider /root/collider_root/src

	ln -s /root/apprtc/src/collider/collidermain /root/collider_root/src

	ln -s /root/apprtc/src/collider/collidertest /root/collider_root/src

	ln -s /root/golang.org /root/collider_root/src

	echo "export GOPATH=/root/collider_root" >> /etc/profile

	. /etc/profile

	echo ${GOPATH}

	cd /root/collider_root/src

	go get collidermain

	go install collidermain
}

init_roomserver(){

	. /etc/profile

	cd /root/apprtc

	apt install -y default-jre

	npm install grunt-closurecompiler
	
	npm install 
	
	easy_install -U requests

	sed -i 's|wss://|ws://|' src/app_engine/apprtc.py

	sed -i 's|https://|http://|' src/app_engine/apprtc.py

	machine_ip=$(ip add | grep inet | grep eth0 | awk '{print $2}' | sed  's|/.*$||')

	sed -i 's|apprtc-ws.webrtc.org:443|'${machine_ip}':8089|' src/app_engine/constants.py
	sed -i 's|apprtc-ws-2.webrtc.org:443|'${machine_ip}':8089|' src/app_engine/constants.py

	grunt build
}

init_roomserver
init_collider

case ${1} in
	init)
		;;
	start)
		echo "hello"
		;;
	*)
		exec $@
		;;
esac
