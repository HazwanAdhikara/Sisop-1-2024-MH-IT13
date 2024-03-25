#!/bin/bash

wget -O genshin.zip "https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN"

unzip genshin.zip
unzip genshin_character.zip

for filename in genshin_character/*.jpg; do
    basename=$(basename "$filename" .jpg)
    newname=$(echo -n "$basename" | xxd -p -r | tr -cd '[:alnum:] [:space:]')

    Region=$(awk -F ',' -v name="$newname" '$1 == name {print $2}' list_character.csv)
    Elemen=$(awk -F ',' -v name="$newname" '$1 == name {print $3}' list_character.csv)
    Senjata=$(awk -F ',' -v name="$newname" '$1 == name {print $4}' list_character.csv)

    new_filename=$(echo "${Region}-${newname}-${Elemen}-${Senjata}.jpg" | tr -d '\r')

    mkdir -p "genshin_character/$Region"

    mv "$filename" "genshin_character/$Region/$new_filename"

done

tail -n +2 list_character.csv | awk -F ',' '{print $4}' | sort | uniq -c | awk '{print $1,":",$2}'

rm -rf genshin.zip
rm -rf genshin_character.zip
rm -rf list_character.csv
