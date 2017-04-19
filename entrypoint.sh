
#!/bin/bash

set -e

if [ -d /root/init ];then
	
	for x in $(ls /root/init)
	do
		if [ -f /root/init/$x ];then
			chmod u+x /root/init/$x
			/bin/bash /root/init/$x
		fi
	done

	rm -rf /root/init
fi

#if [ -f /root/init/roomsrv.sh ];then
#	chmod u+x /root/init/roomsrv.sh
#	/bin/bash /root/init/roomsrv.sh
#	rm -rf /room/init/roomsrv.sh
#fi
#
#if [ -f /root/init/collider.sh ];then
#	chmod u+x /root/init/collider.sh
#	/bin/bash /root/init/collider.sh
#	rm -rf /room/init/collider.sh
#fi

case ${1} in
	init)
		;;
	start)
		rm -rf /var/run/supervisor.sock
		exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
		;;
	*)
		exec "$@"
		;;
esac


