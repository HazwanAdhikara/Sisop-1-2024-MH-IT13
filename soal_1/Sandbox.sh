#!/bin/bash

curl -L -o Sandbox.txt 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'

echo "Contents of Sandbox.txt:"
cat Sandbox.txt

awk -F',' 'BEGIN {OFS="|"} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}' Sandbox.txt > hasil.txt

echo -e "\nContents of hasil.txt:"
cat hasil.txt

awk -F'|' '{print $17,$0}' hasil.txt | sort > sales_urut.txt
echo -e "\nContents of sales_urut.txt:"
cat sales_urut.txt

awk -F'|' '{print $7,$20}' hasil.txt | sort -r > segment_urut.txt
echo -e "\nContents of segment_urut.txt:"
cat segment_urut.txt

awk -F'|' '{print $14,$20}' hasil.txt | sort | tail -n 3 > category_urut.txt
echo -e "\nContents of category_urut.txt (top 3):"
cat category_urut.txt

grep 'Adriaens' hasil.txt | awk -F'|' '{print $2, $18}' > adriaens.txt
echo -e "\nContents of adriaens.txt:"
cat adriaens.txt
