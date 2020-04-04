keyboard=`swaymsg  -t get_inputs input keyboard |grep xkb_active_layout_name |sort -u |cut -d":" -f2 | sed 's/["|,]//g'`
blue="#[fg=colour39]"
yellow="#[fg=colour7]"
echo "$blue $keyboard$yellow"
