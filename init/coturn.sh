#!/bin/bash


set -e


coturn_init(){

	echo "coturn init ......"
	
	cd /root

	tar xvfz libevent-2.0.21-stable.tar.gz

	cd /root/libevent-2.0.21-stable

	./configure

	make install 

	cd /root/coturn

	./configure

	make install

	/usr/local/bin/turnadmin -k -u demo -p 4080218913 -r demo

#	cp /root/coturn/examples/etc/turnserver.conf /etc/turnserver.conf
	
	cp /root/coturn/examples/etc/turn_server_cert.pem /root/ssl/apprtc_cert.pem

	cp /root/coturn/examples/etc/turn_server_pkey.pem /root/ssl/apprtc_pkey.pem

	cat <<EOF >/etc/turnserver.conf
listening-port=3478
static-auth-secret=4080218913
realm=demo
user=demo:4080218913
cert=/root/ssl/apprtc_cert.pem
pkey==/root/ssl/apprtc_pkey.pem
EOF

}


coturn_init
