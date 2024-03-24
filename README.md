# PRAKTIKUM SISOP-1-2024-MH-IT13

**KELOMPOK IT13**
| Nama                      | NRP        |
|---------------------------|------------|
|Muhamad Arrayyan              | 5027231014 |
|Hazwan Adhikara Nasution      | 5027231017 |
|Muhammad Andrean Rizq Prasetio     | 5027231052 |

## Pengantar
Laporan resmi ini dibuat terkait dengan praktikum modul 1 sistem operasi yang telah dilaksanakan pada tanggal xx hingga tanggal xx. Praktikum modul 1 terdiri dari 4 soal yang dikerjakan oleh kelompok praktikan yang terdiri dari 3 orang selama waktu tertentu.

Kelompok IT13 melakukan pengerjaan modul 1 ini dengan pembagian sebagai berikut:
  + Soal 1 dikerjakan oleh Hazwan Adhikara Nasution
  + Soal 2 dikerjakan oleh Muhamad Arrayyan 
  + Soal 3 dikerjakan oleh Muhammad Andrean Rizq Prasetio; dan
  + Soal 4 dikerjakan bersama oleh (Hazwan XX%, Rayyan XX%, Andre XX%)
Sehingga dengan demikian, semua anggota kelompok memiliki peran yang sama besar dalam pengerjaan modul 1 ini.

Kelompok IT13 juga telah menyelesaikan tugas praktikum modul 1 yang telah diberikan dan telah melakukan demonstrasi kepada Asisten lab MAS/MBA SEKIAN. Dari hasil praktikum yang telah dilakukan sebelumnya, maka diperoleh hasil sebagaimana yang dituliskan pada setiap bab di bawah ini.

## Ketentuan
Struktur Repository Seperti Berikut:
```
—soal_1:
  	— Sandbox.sh
                                    
—soal_2:
  	— Login.sh
	— Register.sh
				
—soal_3:
  	— awal.sh
	— search.sh
				
—soal_4:
	— aggregate_minutes_to_hourly_log.sh
	— minute_log.sh
```
---
### **`Soal 1`**
`> Hazwan`

#### > Isi Soal
Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan.

Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe 

- Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi
- Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit - paling kecil. Tampilkan customer segment yang memiliki profit paling kecil
- Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi 
- Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens

#### > Penyelesaian
```
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
```
#### > Penjelasan
- Langkah pertama, kami diminta untuk mendownload sebuah file bernama "Sandbox.sh" yang ketika file tersebut dibuka langsung diarahkan ke google drive yang berisi data penjualan dengan 20 kolom. Oleh karena itu, kita download file tersebut dan mengubahnya menjadi Sandbox.csv agar bisa melanjutkan step selanjutnya.
```
curl -L -o Sandbox.csv 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
```
`Command tersebut adalah untuk download file dari link gdrive tersebut dan menyimpannya dengan nama Sandbox.csv`

- Kami perlu mengecek isi dari Sandbox.csv untuk melihat apakah datanya sesuai.
```
cat Sandbox.csv
```
`Command tersebut memperlihatkan isi file dari Sandbox.csv`

- Setelah melihat isi file tersebut dari terminal, saya merasa bawa data tersebut terlalu sulit dan berantakan untuk dibaca. Oleh karena itu, saya mengubah tampilan isi data tersebut agar lebih mudah dibaca, dengan cara:
```
awk -F',' 'BEGIN {OFS="|"} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}' Sandbox.csv > data.txt
```
`Saya mengubah tampilan dari yang berantakan lalu memasukkan hasil perubahan commandnya ke data.txt`

- Lalu, cek apakah isi data.txt sudah memenuhi command diatas.
```
cat data.txt
```
`Ternyata, sudah sesuai apa yang kami inginkan. Data sudah tertampil dengan rapih`

- Pada Poin Pertama, kami diminta untuk menampilkan nama pembeli dengan total sales paling tinggi.
```
awk -F'|' '{print $17,$6}' data.txt | sort | tail -n 2 > sales.txt
```
lalu
```
cat sales.txt
```
`Command Tersebut berfungsi untuk melakukan sorting pada kolom 17 pada file data.txt agar bisa memperlihatkan urutan total sales paling tinggi dan memasukkannya ke file sales.txt. Setelah itu, mengecek isi file sales.txt apakah sudah sesuai dengan apa yang diminta soal`

- Untuk Poin Kedua, kami juga diminta untuk menampilkan customer segment yang memiliki profit paling kecil.
```
awk -F'|' '{print $20,$7}' data.txt | sort | head -n 1 > segment.txt
```
```
cat segment.txt
```
`Yang kami lakukan dengan command itu adalah melakukan sorting untuk kolom 7 dan 20. Setelah disorting diprint hasil yang sudah terurut lalu kami masukkan ke file segment.txt dan kami bisa melihat isi file dengan cara cat segment.txt`

- Untuk Poin Ketiga, kami diminta untuk meampilkan 3 category yang memiliki total profit paling tinggi.
```
awk -F'|' '{print $20,$14}' data.txt | sort | tail -n 4 > category.txt
```
```
cat category.txt
```
`Dari command tersebut, kami juga melakukan sorting untuk kolom 14 dan 20, lalu yang ditambilkan adalah tail n -3 untuk memperlihatkan 3 tertinggi, kenapa tail? karena saat kami sorting, semakin bawah semakin tinggi, oleh karena itu kami menampilkan 3 data terbawah dan seterusnya gunakan cat category.txt untuk melihat isi filenya`

- Untuk Poin Keempat, pada poin terakhir ini kami diminta untuk mencari purchase date dan amount (quantity) dari nama adriaens.
```
grep 'Adriaens' data.txt | awk -F'|' '{print $2, $18}' > adriaens.txt
```
```
cat adriaens.txt
```
`Untuk mencari nama customer, kami gunakan grep pada file data.txt dengan mencari nama Adriaens. Jika ketemu, satu baris yang ada nama Adriaens akan diproses dengan cara mengambil data pada kolom 2 dan 18, lalu dimasukkan ke file adriaens.txt. Cat untuk melihat isi file tersebut.`

#### > Dokumentasi
<img width="1523" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/10901a5c-b577-49c4-b85d-bb9e0ddb489a">
<img width="1531" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/5e027480-43b2-4f77-97a1-09846e28099c">
<img width="1531" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/6b4a9ad6-95a9-4443-bed0-03e434f0163c">
<img width="1534" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/a22945d0-f9d6-460e-9a27-cc6ec2265d65">
<img width="1527" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/73f5f6fb-2bc7-42c2-acd2-f224f3c2b175">
<img width="1533" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/a0e84095-a0ec-4850-831d-d61d0f4d8bc5">
<img width="1534" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/71181cae-16b3-4143-9ca6-ab884a6ea6d2">







---
### **`Soal 2`**

#### > Isi Soal

#### > Penyelesaian

#### > Penjelasan

#### > Dokumentasi
---
### **`Soal 3`**

#### > Isi Soal

#### > Penyelesaian

#### > Penjelasan

#### > Dokumentasi
---
### **`Soal 4`**

#### > Isi Soal

#### > Penyelesaian

#### > Penjelasan

#### > Dokumentasi
---
## Kesimpulan 
ini untuk kesimpulan akhirnya yaa nanti diisi
