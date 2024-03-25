#!/bin/bash

datetime=$(date "+%Y%m%d%H")

log_directory="/home/$(whoami)/sisop/modul1/soal4/log/minute/"
output_directory="/home/$(whoami)/sisop/modul1/soal4/log/hour/"

# bikin array untuk tempat ngisi log
declare -a dir_sizes=()

# loop untuk isi log selama 1 jam
for logfile in $(find $log_directory -type f -mmin -60 -name "metrics_*.log"); do
    while IFS=, read -r mem_total mem_used mem_free mem_shared mem_buff mem_available swap_total swap_used swap_free path path_size; do
        dir_sizes+=("$mem_total,$mem_used,$mem_free,$mem_shared,$mem_buff,$mem_available,$swap_total,$swap_used,$swap_free,$path,$path_size")
    done < "$logfile"
done

sorted_sizes=($(printf "%s\n" "${dir_sizes[@]}" | sort -t',' -k11,11))
min_size="${sorted_sizes[0]}"
max_size="${sorted_sizes[-1]}"

IFS=',' read -r -a min_arr <<< "$min_size"
IFS=',' read -r -a max_arr <<< "$max_size"
avg_arr=()

for ((i=0; i<${#min_arr[@]}-2; i++)); do
    avg_val=$(echo "scale=2; (${min_arr[$i]} + ${max_arr[$i]}) / 2" | bc)
    # cek apakah hasilnya integer
    if [[ $avg_val =~ ^[0-9]+(\.0+)?$ ]]; then
        avg_arr+=("${avg_val%.*}")
    else
        avg_arr+=("$avg_val")
    fi
done

avg_arr+=("${min_arr[-2]}")

# buat ngitung sama bikin format path_size secara terpisah
min_path_size=${min_arr[-1]%K}
max_path_size=${max_arr[-1]%K}
avg_path_size=$(echo "scale=2; ($min_path_size + $max_path_size) / 2" | bc)
if [[ $avg_path_size =~ ^[0-9]+(\.0+)?$ ]]; then
    avg_path_size="${avg_path_size%.*}K" # menghapus .0 lalu ditambahkan K
else
    avg_path_size="${avg_path_size}K"
fi
avg_arr+=("$avg_path_size")

avg_line="average"
for val in "${avg_arr[@]}"; do
    avg_line+=",${val}"
done

output_file="$output_directory/metrics_agg_${datetime}.log"

echo "minimum,$min_size" > "$output_file"
echo "maximum,$max_size" >> "$output_file"
echo "$avg_line" >> "$output_file"

chmod 600 /home/$(whoami)/sisop/modul1/soal4/log/hour/metrics_agg${datetime}.log

# mencetak metrik tiap menit pada crontab -e
# 0 * * * * /home/zwaneee/sisop/modul1/soal4/log/hour/aggregate_minutes_to_hourly_log.sh

