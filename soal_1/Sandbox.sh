#!/bin/bash

curl -L -o Sandbox.csv 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'

echo "Contents of Sandbox.csv:"
cat Sandbox.csv

awk -F',' 'BEGIN {OFS="|"} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}' Sandbox.csv > data.txt

echo -e "\nContents of data.txt:"
cat data.txt

awk -F'|' '{print $17,$6}' data.txt | sort | tail -n 2 > sales.txt

echo -e "\nTop sales:"
cat sales.txt

awk -F'|' '{print $20,$7}' data.txt | sort | head -n 1 > segment.txt

echo -e "\nSegment with smallest value:"
cat segment.txt

awk -F'|' '{print $20,$14}' data.txt | sort | tail -n 4 > category.txt

echo -e "\nTop 3 categories:"
cat category.txt

grep 'Adriaens' data.txt | awk -F'|' '{print $2, $18}' > adriaens.txt

echo -e "\nAdriaens:"
cat adriaens.txt
