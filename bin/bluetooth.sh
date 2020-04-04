if [ $1 == 'off' ]
then
    echo "power off" | bluetoothctl
else
    echo -e "power on\n connect CC:98:8B:D2:0B:72\n"| bluetoothctl
fi
