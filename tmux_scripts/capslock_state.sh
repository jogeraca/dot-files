state=`cat /sys/class/leds/input5::capslock/brightness`
off="#[fg=corlor7]"
on="#[fg=colour28]"
if [ $state -eq 1 ] 
    then
    echo "${on}" 
else
    echo "${off}" 
fi
