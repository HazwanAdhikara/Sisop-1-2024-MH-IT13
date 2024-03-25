#!/bin/bash

datetime=$(date "+%Y%m%d%H%M%S")

metrics=$(free -m | awk 'NR==2 {printf "%s,%s,%s,%s,%s,%s", $2, $3, $4, $5, $6, $7}')

path="/home/$(whoami)/sisop/modul1/soal4/log/minute/"
path_size=$(du -sh $path | awk '{print $1}')

swap_total=$(free | awk 'NR==3 {print $2}')
swap_used=$(free | awk 'NR==3 {print $3}')
swap_free=$(free | awk 'NR==3 {print $4}')

echo "$metrics,$swap_total,$swap_used,$swap_free,$path,$path_size" > /home/$(whoami)/sisop/modul1/soal4/log/minute/metrics_${datetime}.log

chmod 600 /home/$(whoami)/sisop/modul1/soal4/log/minute/metrics_${datetime}.log

# mencetak metrik tiap menit pada crontab -e
# * * * * * /home/zwaneee/sisop/modul1/soal4/log/minute/minute_log.sh
