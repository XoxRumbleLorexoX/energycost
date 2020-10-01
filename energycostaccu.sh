#!/bin/bash
echo "How much do you pay for your electricity per kWh?"
read ui
echo "How many seconds would you like this program to run for?"
read xx
for ((i=0; i<${xx}; i++)); do
  w=$(sudo powermetrics -n 1 -i 1000 --show-process-energy|grep 'SA'|egrep -o '[0-9]+.[0-9]+')
  cw=$(echo "scale=15; $ui/3600000"|bc|awk '{printf "%f", $0}')
  curr=$(echo "scale=15; $w * $cw"|bc|awk '{printf "%f", $0}')
  echo "How much you spent (in the last sec)= $w * $cw = $curr"
  declare -a curop
  curop[i]+=$curr
  five=$(awk 'BEGIN {t=0; for (i in ARGV) t+=ARGV[i]; print t}' "${curop[@]}")
  echo "You're energy cost so far: $five"
done
