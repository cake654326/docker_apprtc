
#!/bin/bash

set -e

init_collider(){

		echo "collider init ....."

		mkdir -p /root/collider_root/src

		ln -s /root/apprtc/src/collider/collider /root/collider_root/src

		ln -s /root/apprtc/src/collider/collidermain /root/collider_root/src

		ln -s /root/apprtc/src/collider/collidertest /root/collider_root/src

		ln -s /root/golang.org /root/collider_root/src

		machine_ip=$(ip add | grep inet | grep eth0 | awk '{print $2}' | sed  's|/.*$||')

		if [ ${ROOMSVR_HOST} ];then
			sed -i 's|https://appr.tc|'${ROOMSVR_HOST}'|' /root/collider_root/src/collidermain/main.go
		else
			sed -i 's|https://appr.tc|'${machine_ip}'|' /root/collider_root/src/collidermain/main.go
		fi

		sed -i 's|/cert/cert.pem|/root/ssl/apprtc_cert.pem|' /root/collider_root/src/collider/collider.go
		sed -i 's|/cert/key.pem|/root/ssl/apprtc_pkey.pem|' /root/collider_root/src/collider/collider.go

		echo "export GOPATH=/root/collider_root" >> /etc/profile

		. /etc/profile

		cd /root/collider_root/src

		go get collidermain

		go install collidermain

}

init_collider
