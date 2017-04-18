#!/bin/bash

mkdir -p /root/collider_root/src

ln -s /root/apprtc/src/collider/collider /root/collider_root/src

ln -s /root/apprtc/src/collider/collidermain /root/collider_root/src

ln -s /root/apprtc/src/collider/collidertest /root/collider_root/src

ln -s /root/golang.org /root/collider_root/src

echo "export GOPATH=/root/collider_root" >> /etc/profile

source /etc/profile

cd /root/collider_root/src

go get collidermain

go install collidermain

machine_ip=$(ip add | grep inet | grep eth0 | awk '{print $2}' | sed  's|/.*$||')


nohup /root/collider_root/bin/collidermain -port=8089 -tls=false room-server=${machine_ip}:8080 &
