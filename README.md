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

```
#### > Penjelasan
- Langkah pertama, kami diminta untuk mendownload sebuah file bernama "Sandbox.sh" yang ketika file tersebut dibuka langsung diarahkan ke google drive yang berisi data penjualan dengan 20 kolom. Oleh karena itu, kita download file tersebut dan mengubahnya menjadi Sandbox.txt agar bisa melanjutkan step selanjutnya.
```
curl -L -o Sandbox.txt 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
```
`Command tersebut adalah untuk download file dari link gdrive tersebut dan menyimpannya dengan nama Sandbox.txt`

- Kami perlu mengecek isi dari Sandbox.txt untuk melihat apakah datanya sesuai.
```
cat Sandbox.txt
```
`Command tersebut memperlihatkan isi file dari Sandbox.txt`

- Setelah melihat isi file tersebut dari terminal, saya merasa bawa data tersebut terlalu sulit dan berantakan untuk dibaca. Oleh karena itu, saya mengubah tampilan isi data tersebut agar lebih mudah dibaca, dengan cara:
```
awk -F',' 'BEGIN {OFS="|"} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}' Sandbox.txt > hasil.txt
```
`Saya mengubah tampilan dari yang berantakan lalu memasukkan hasil perubahan commandnya ke hasil.txt`

- Lalu, cek apakah isi hasil.txt sudah memenuhi command diatas.
```
cat hasil.txt
```
`Ternyata, sudah sesuai apa yang kami inginkan. Data sudah tertampil dengan rapih`

- Pada Poin Pertama, kami diminta untuk menampilkan nama pembeli dengan total sales paling tinggi.
```
awk -F'|' '{print $17,$0}' hasil.txt | sort > sales_urut.txt
```
lalu
```
cat sales_urut.txt
```
`Command Tersebut berfungsi untuk melakukan sorting pada kolom 17 pada file hasil.txt agar bisa memperlihatkan urutan total sales paling tinggi dan memasukkannya ke file sales_urut.txt. Setelah itu, mengecek isi file sales_urut.txt apakah sudah sesuai dengan apa yang diminta soal`

- Untuk Poin Kedua, kami juga diminta untuk menampilkan customer segment yang memiliki profit paling kecil.
```
awk -F'|' '{print $7,$20}' hasil.txt | sort -r > segment_urut.txt
```
```
cat segment_urut.txt
```
`Yang kami lakukan dengan command itu adalah melakukan sorting untuk kolom 7 dan 20. Setelah disorting diprint hasil yang sudah terurut lalu kami masukkan ke file segment_urut.txt dan kami bisa melihat isi file dengan cara cat segment_urut.txt`

- Untuk Poin Ketiga, kami diminta untuk meampilkan 3 category yang memiliki total profit paling tinggi.
```
awk -F'|' '{print $14,$20}' hasil.txt | sort | tail -n 3 > category_urut.txt
```
```
cat category_urut.txt
```
`Dari command tersebut, kami juga melakukan sorting untuk kolom 14 dan 20, lalu yang ditambilkan adalah tail n -3 untuk memperlihatkan 3 tertinggi, kenapa tail? karena saat kami sorting, semakin bawah semakin tinggi, oleh karena itu kami menampilkan 3 data terbawah dan seterusnya gunakan cat category_urut.txt untuk melihat isi filenya`

- Untuk Poin Keempat, pada poin terakhir ini kami diminta untuk mencari purchase date dan amount (quantity) dari nama adriaens.
```
grep 'Adriaens' hasil.txt | awk -F'|' '{print $2, $18}' > adriaens.txt
```
```
cat adriaens.txt
```
`Untuk mencari nama customer, kami gunakan grep pada file hasil.txt dengan mencari nama Adriaens. Jika ketemu, satu baris yang ada nama Adriaens akan diproses dengan cara mengambil data pada kolom 2 dan 18, lalu dimasukkan ke file adriaens.txt. Cat untuk melihat isi file tersebut.`

#### > Dokumentasi
<img width="882" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/f26e096b-de82-4b10-a12c-b441bc498a39">

<img width="892" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/1bd92694-55d5-43d3-91b7-c0329788f04f">

<img width="883" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/4923911f-eed2-44b8-b35e-67705fb5e96e">

<img width="1404" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/4d91c0d4-30ee-4c4f-b82e-25f996aa6bc1">

<img width="540" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/4c963840-e533-4540-b7f3-5cfba4b676f1">

<img width="1405" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/d755c8f5-3390-4a5f-b935-a67173443258">

<img width="578" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/92ccdf61-ba05-4c4e-a0d9-aa204dc9e7e8">

<img width="349" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/f5eb8944-e7da-46e3-b888-ed35c2580626">

<img width="580" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/8b7a49fc-73e7-40a1-9129-327b2a64749f">

<img width="350" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/9c77c999-5dba-44ba-86b0-4e4b72523886">

<img width="663" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/fdab76cd-8598-4923-b731-0bcf03a69a18">

<img width="362" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/9ee642fa-c22f-4630-ad58-37d024195a7d">

<img width="611" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/236fceb7-95bb-4daf-8c19-b4b80963c18a">

<img width="343" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/b9e6aeb2-0204-4fd3-a90d-45fb1d0f6cd2">

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
