
#!/bin/bash

set -e

if [ -d /root/init ];then
	
	for x in $(ls /root/init)
	do
		if [ -f /root/init/$x ];then
			chmod u+x /root/init/$x
			/bin/bash /root/init/$x
			rm -rf /root/init/$x
		fi
	done
fi


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


