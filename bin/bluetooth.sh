if [ $1 == 'off' ]
  then
    echo "power off" | bluetoothctl
elif [ $1 == 'on' ]
  then
        echo -e "agent KeyboardOnly\ndefault-agent\npower on\n scan on"| bluetoothctl
elif [ $1 == 'con' ]
  then
      echo -e "pair CC:98:8B:D2:0B:72\n" | bluetoothctl
      sleep 10
      echo -e "connect CC:98:8B:D2:0B:72\n" | bluetoothctl
elif [ $1 == 'res' ]
      then
      echo "power off" | bluetoothctl
      echo -e "power on\n scan on"| bluetoothctl
      sleep 10
      echo -e "pair CC:98:8B:D2:0B:72\n" | bluetoothctl
      sleep 10
      echo -e "connect CC:98:8B:D2:0B:72\n" | bluetoothctl
fi
