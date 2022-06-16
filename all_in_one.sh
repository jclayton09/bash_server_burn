#! /usr/bin/bash

# sudo apt-get install sshpass

PASSWORD=$3
USERNAME=$2
IP=$3

until ping -c1 $IP >/dev/null 2>&1;
do
echo "Waiting for server to boot"
done

TIME=$(sshpass -p ${PASSWORD} ssh ${USERNAME}@${IP} 'date +"%Y-%m-%d %H:%M:%S"')

sshpass -p ${PASSWORD} ssh ${USERNAME}@${IP} "echo $PASSWORD | sudo -S timedatectl set-timezone UTC"
echo "It's a magic password"
eval "sudo timedatectl set-ntp false"
# command to be able to set the time (disbale automatic sync)
eval "sudo timedatectl set-timezone UTC"
# sets the timezone to UTC

if [ -z "$TIME" ]
# checks if the variable was assigned a time
then
echo "Couldn't find the new time"
else
# echo $TIME
echo 'Setting the new time to:'
eval "sudo date -s '${TIME}'"
# command to set the date to the variable
fi

x-terminal-emulator --title='CPU' --command="sshpass -p ${PASSWORD} ssh ${USERNAME}@${IP} 'echo ${PASSWORD} | sudo -S Unified_Server_PTU_V3.6.1_20211216/ptu -ct 1'"
# x-terminal-emulater brings up another command window named CPU
# sshpass enters the password in for you
# echo + sudo -S is how to enter the password from stdin

x-terminal-emulator --title='GPU' --command="sshpass -p ${PASSWORD} ssh ${USERNAME}@${IP} 'echo ${PASSWORD} | sudo -S bash gpu-burn.sh'"

