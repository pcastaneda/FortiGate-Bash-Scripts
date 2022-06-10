#!/bin/bash


# Individual Fortigate settings 
HOST="x.x.x.x"						# Fortigate hostname of IP (must be accessible via ssh)
USER="admin"						# Fortigate username
PASS="password"						# Fortigate password
						



NOW=$(date +"_%m-%d-%Y")
CMD=$@

echo "Fortigate backup"
echo "beginning backup...."

SCRIPT=$(expect -c "
		spawn scp -o StrictHostKeyChecking=no $USER@$HOST:sys_config . $CMD
		match_max 100000
		expect \"*?assword:*\"
		send -- \"$PASS\r\"
		expect \"*?#*\"
		send -- \"sys_config /root\"
		send -- \"\r\"
		expect eof
")

echo "$SCRIPT"
echo "script finished. note any errors above"
