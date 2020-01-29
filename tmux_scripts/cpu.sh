blue="#[fg=blue]"
white="#[fg=white]"
red="#[fg=red]"
gray="#[fg=colour244]"
color="#[fg=colour7]"

use=`df -H | grep "nvme"  |  awk '{color=($5>"70"?"'$red'":($5>"50"?"'$gray'":"'$white'")); printf "%s%s:%s%s%s", "'$blue'", $6, color, $5, "'$color'"}'`
echo $use
