
#!/bin/bash

set -e

init_collider(){

		echo "collider init ....."

		mkdir -p /root/collider_root/src

		ln -s /root/apprtc/src/collider/collider /root/collider_root/src

		ln -s /root/apprtc/src/collider/collidermain /root/collider_root/src

		ln -s /root/apprtc/src/collider/collidertest /root/collider_root/src

		ln -s /root/golang.org /root/collider_root/src

		echo "export GOPATH=/root/collider_root" >> /etc/profile

		. /etc/profile

		cd /root/collider_root/src

		go get collidermain

		go install collidermain

}

init_collider
