# PRAKTIKUM SISOP-1-2024-MH-IT13

**KELOMPOK IT13**
| Nama                      | NRP        |
|---------------------------|------------|
|Muhamad Arrayyan              | 5027231014 |
|Hazwan Adhikara Nasution      | 5027231017 |
|Muhammad Andrean Rizq Prasetio     | 5027231052 |

## Pengantar
Laporan resmi ini dibuat terkait dengan praktikum modul 1 sistem operasi yang telah dilaksanakan pada tanggal 20 Maret 2024 hingga tanggal 30 Maret 2024. Praktikum modul 1 terdiri dari 4 soal yang dikerjakan oleh kelompok praktikan yang terdiri dari 3 orang selama waktu tertentu.

Kelompok IT13 melakukan pengerjaan modul 1 ini dengan pembagian sebagai berikut:
  + Soal 1 dikerjakan oleh Hazwan Adhikara Nasution
  + Soal 2 dikerjakan oleh Muhamad Arrayyan 
  + Soal 3 dikerjakan oleh Muhammad Andrean Rizq Prasetio; dan
  + Soal 4 dikerjakan oleh Hazwan Adhikara Nasution

Sehingga dengan demikian, Pembagian bobot pengerjaan soal menjadi (Rayyan 30%, Hazwan 40%, Andre 30%).

Kelompok IT13 juga telah menyelesaikan tugas praktikum modul 1 yang telah diberikan dan telah melakukan demonstrasi kepada Asisten lab. Dari hasil praktikum yang telah dilakukan sebelumnya, maka diperoleh hasil sebagaimana yang dituliskan pada setiap bab di bawah ini.

## Ketentuan
Struktur Repository Seperti Berikut:
```bash
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
```bash
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

#### > Revisi

- Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan **total sales paling tinggi**. Pada penjelasan poin diatas, saya melakukan sedikit kesalahan yang dimana pada poin ini tidak sesuai dengan yang diminta. Berikut adalah perbaikan mengenai poin tersebut:

<img width="1425" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/abd68520-7202-4c43-ad1f-b2e89b44daff">

- Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. **Tampilkan 3 category yang memiliki total profit paling tinggi**. Saya juga melakukan revisi pada poin ini agar sesuai dengan apa yang diminta. Berikut adalah perbaikan mengenai poin tersebut:

<img width="1424" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/ceebcb0e-1147-4c5c-b029-0ec835f0c2d4">




---
### **`Soal 2`**
`> Rayyan`
#### > Isi Soal
Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan tugasnya 
+ Buatlah 2 program yaitu login.sh dan register.sh
+ Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password
+ Username yang dibuat bebas, namun email bersifat unique. **setiap email yang mengandung kata admin akan dikategorikan menjadi admin**
+ Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi
  - Password tersebut harus di encrypt menggunakan base64
  - Password yang dibuat harus lebih dari 8 karakter
  - Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
  - Harus terdapat paling sedikit 1 angka
+ Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.
+ Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.
+ Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password
+ Setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin.
+ Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit
+ Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.
  - Format: [date] [type] [message]
  - Type: REGISTER SUCCESS, REGISTER FAILED, LOGIN SUCCESS, LOGIN FAILED
  - Example:
    - [23/09/17 13:18:02] [REGISTER SUCCESS] user [username] registered successfully
    - [23/09/17 13:22:41] [LOGIN FAILED] ERROR Failed login attempt on user with email [email]

#### > Penyelesaian

### **`register.sh`**

```bash
#!/bin/bash

read -p "Enter your email: " email
read -p "Enter your username: " username
read -p "Enter your security question: " security_question
read -p "Enter your security answer: " security_answer

if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
   echo "Invalid email format. Please enter a valid email address."
   exit 1
fi

if grep -q "^$email|" users/users.txt; then
   echo "Email address already exists. Please use a different email address."
   exit 1
fi

while true; do
    read -sp "Enter your password: " password
    echo
    if [[ ${#password} -lt 8 || !("$password" =~ [A-Z]) || !("$password" =~ [a-z]) || !("$password" =~ [0-9]) ]]; then
        echo "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit."
    else
        break
    fi
done

encryption_password=$(echo "$password" | base64)

if [[ "$email" == *"admin"* ]]; then
    role="admin"
else
    role="user"
fi

echo "$email|$username|$security_question|$security_answer|$encryption_password|$role" >> users/users.txt
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [REGISTER SUCCESS] user $username registered successfully" >> users/auth.log
echo "Registration successful"
```

### **`login.sh`**

```bash
#!/bin/bash

login_user() {
    read -p "Enter your email: " email
    read -sp "Enter your password: " password
    echo

    if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Invalid email format. Please enter a valid email address."
        return
    fi

    encryption_password=$(echo "$password" | base64)

    user_info=$(grep "$email" users/users.txt)

    if [[ -z $user_info ]]; then
        echo "User not found"
        echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN FAILED] ERROR User with email $email not found" >> users/auth.log
        return
    fi

    stored_encryption_password=$(echo "$user_info" | cut -d '|' -f 5)

    if [[ "$encryption_password" != "$stored_encryption_password" ]]; then
        echo "Incorrect password"
        echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN FAILED] ERROR Failed login attempt on user with email $email" >> users/auth.log
        return
    fi

    echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN SUCCESS] User with email $email logged in successfully" >> users/auth.log

    role=$(echo "$user_info" | cut -d '|' -f 6)
    if [[ "$role" == "admin" ]]; then
        echo "Welcome, admin!"
    	echo "Select action:"
    	echo "a. Add new user"
    	echo "b. Edit existing user"
    	echo "c. Delete user"
    	echo "d. Log Out Admin"
    	read -p "Enter your choice: " choice

add_new_user() {
    read -p "Enter new user's email: " new_email
    read -p "Enter new user's username: " new_username
    read -p "Enter new user's security question: " new_security_question
    read -p "Enter new user's security answer: " new_security_answer

    if [[ ! "$new_email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Invalid email format. Please enter a valid email address."
        return
    fi

    if grep -q "^$new_email|" users/users.txt; then
        echo "Email address already exists. Please use a different email address."
        return
    fi

    while true; do
        read -sp "Enter new user's password: " new_password
        echo
        if [[ ${#new_password} -lt 8 || !("$new_password" =~ [A-Z]) || !("$new_password" =~ [a-z]) || !("$new_password" =~ [0-9]) ]]; then
            echo "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit."
        else
            break
        fi
    done

    new_encryption_password=$(echo "$new_password" | base64)

    if [[ "$new_email" == *"admin"* ]]; then
        role="admin"
    else
        role="user"
    fi

    echo "$new_email|$new_username|$new_security_question|$new_security_answer|$new_encryption_password|$role" >> users/users.txt

    echo "User $new_email added successfully"
}

edit_user() {
    user_info=$(grep "$edit_email" users/users.txt)
    if [[ -z $user_info ]]; then
        echo "User not found"
        return
    fi

    current_username=$(echo "$user_info" | cut -d '|' -f 2)
    current_security_question=$(echo "$user_info" | cut -d '|' -f 3)
    current_security_answer=$(echo "$user_info" | cut -d '|' -f 4)
    current_encryption_password=$(echo "$user_info" | cut -d '|' -f 5)

    read -p "Enter new username: " new_username
    if [[ -z "$new_username" ]]; then
        new_username="$current_username"
    fi

    read -p "Enter new security question: " new_security_question
    if [[ -z "$new_security_question" ]]; then
        new_security_question="$current_security_question"
    fi

    read -p "Enter new security answer: " new_security_answer
    if [[ -z "$new_security_answer" ]]; then
        new_security_answer="$current_security_answer"
    fi

    while true; do
        read -sp "Enter new password: " new_password
        echo
        if [[ ${#new_password} -lt 8 || !("$new_password" =~ [A-Z]) || !("$new_password" =~ [a-z]) || !("$new_password" =~ [0-9]) ]]; then
            echo "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit."
        else
            break
        fi
    done
    new_encryption_password=$(echo "$new_password" | base64)

    new_user_info=$(echo "$user_info" | sed "s/$current_username/$new_username/" | sed "s/$current_security_question/$new_security_question/" | sed "s/$current_security_answer/$new_security_answer/" | sed 
    "s/$current_encryption_password/$new_encryption_password/")

    sed -i "s/$user_info/$new_user_info/" users/users.txt

    echo "User $edit_email edited successfully"
}

delete_user() {
    user_info=$(grep "$delete_email" users/users.txt)
    if [[ -z $user_info ]]; then
        echo "User not found"
        return
    fi

    sed -i "/$delete_email/d" users/users.txt

    echo "User $delete_email deleted successfully"
}

logout_admin() {
    echo "Exit"
    exit 0
}

    case $choice in
    a)      add_new_user
            ;;
    b)      read -p "Enter email of the user to edit: " edit_email
            edit_user
            ;;
    c)      read -p "Enter email of the user to delete: " delete_email
            delete_user
            ;;
    d)      logout_admin
            ;;
    *)      echo "Invalid choice"
            ;;
            
    esac
    
    else
        echo "Welcome, user!"
    fi
}

forgot_password() {
    read -p "Enter your email: " email
    user_info=$(grep "$email" users/users.txt)
    if [[ -z $user_info ]]; then
        echo "User not found"
        return
    fi
    read -p "Enter your security question: " security_question
    security_question=$(echo "$user_info" | cut -d '|' -f 3)
    read -p "Enter your security answer: " security_answer
    stored_security_answer=$(echo "$user_info" | cut -d '|' -f 4)
    
    if [[ "$security_answer" != "$stored_security_answer" ]]; then
        echo "Incorrect security answer"
        return
    fi
    encryption_password=$(echo "$user_info" | cut -d '|' -f 5 | base64 --decode)
    echo "Your password is: $encryption_password"
}

login_menu() {
    echo "Select action:"
    echo "1. Login"
    echo "2. Forgot Password"
    echo "3. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)  login_user
            ;;
        2)  forgot_password
            ;;   
        3)  echo "Exiting..."
            exit 0
            ;:
        *)  echo "Invalid choice"
            login_menu
            ;;
    esac
}
login_menu
```

#### > Penjelasan

### register.sh

1. Fungsi untuk menginputkan data registrasinya yang terdiri dari email, username, security question, security answer, password

```bash 
read -p "Enter your email: " email
read -p "Enter your username: " username
read -p "Enter your security question: " security_question
read -p "Enter your security answer: " security_answer

if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Invalid email format. Please enter a valid email address."
    exit 1
fi

if grep -q "^$email|" users/users.txt; then
    echo "Email address already exists. Please use a different email address."
    exit 1
fi

while true; do
    read -sp "Enter your password: " password
    echo
    if [[ ${#password} -lt 8 || !("$password" =~ [A-Z]) || !("$password" =~ [a-z]) || !("$password" =~ [0-9]) ]]; then
        echo "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit."
    else
        break
    fi
done
```

2. Fungsi untuk encryption password menggunakan base64
```bash
encryption_password=$(echo "$password" | base64)
```

3. Fungsi untuk mengecek apakah email termasuk kedalam admin atau user
```bash
if [[ "$email" == *"admin"* ]]; then
    role="admin"
else
    role="user"
fi
```

4. Fungsi untuk merekam data register yang diinputkan agar tersimpan kedalam users.txt
```bash
echo "$email|$username|$security_question|$security_answer|$encryption_password|$role" >> users/users.txt
```

5. Fungsi untuk merekam data register yang diinputkan agar tersimpan kedalam auth.log 
```bash
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [REGISTER SUCCESS] user $username registered successfully" >> users/auth.log
```

6. Registrasi telah berhasil 
```bash
echo "Registration successful"
```

### login.sh

1. Fungsi untuk login dengan memasukkan email dan password yang sudah tersimpan di data registrasi yang berada di user.txt

```bash
login_user() {
    read -p "Enter your email: " email
    read -sp "Enter your password: " password
    echo

    if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Invalid email format. Please enter a valid email address."
        return
    fi
```

2. Fungsi untuk encryption password menggunakan base64
```bash
encryption_password=$(echo "$password" | base64)
```

3. Fungsi untuk memeriksa apakah pengguna ada di users.txt
```bash
user_info=$(grep "$email" users/users.txt)
    if [[ -z $user_info ]]; then
        echo "User not found"
        echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN FAILED] ERROR User with email $email not found" >> users/auth.log
        return
    fi
```

4. Fungsi untuk decryption kata sandi yang disimpan
```bash
stored_encryption_password=$(echo "$user_info" | cut -d '|' -f 5)
```

5. Fungsi untuk memverifikasi password 
```bash
    if [[ "$encryption_password" != "$stored_encryption_password" ]]; then
        echo "Incorrect password"
```

6. Fungsi untuk merekam data login sehingga tersimpan kedalam auth.log
```bash
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN FAILED] ERROR Failed login attempt on user with email $email" >> users/auth.log
        return
    fi
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN SUCCESS] User with email $email logged in successfully" >> users/auth.log
```

7. Fungsi untuk mengecek role apakah admin atau user, jika admin akan mendapatkan akses untuk add new user, edit user, delete user, dan log out.
```bash
    role=$(echo "$user_info" | cut -d '|' -f 6)
    if [[ "$role" == "admin" ]]; then
        echo "Welcome, admin!"
    	echo "Select action:"
    	echo "a. Add new user"
    	echo "b. Edit existing user"
    	echo "c. Delete user"
    	echo "d. Log Out Admin"
    	read -p "Enter your choice: " choice

add_new_user() {
    read -p "Enter new user's email: " new_email
    read -p "Enter new user's username: " new_username
    read -p "Enter new user's security question: " new_security_question
    read -p "Enter new user's security answer: " new_security_answer

    if [[ ! "$new_email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Invalid email format. Please enter a valid email address."
        return
    fi

    if grep -q "^$new_email|" users/users.txt; then
        echo "Email address already exists. Please use a different email address."
        return
    fi

    while true; do
        read -sp "Enter new user's password: " new_password
        echo
        if [[ ${#new_password} -lt 8 || !("$new_password" =~ [A-Z]) || !("$new_password" =~ [a-z]) || !("$new_password" =~ [0-9]) ]]; then
            echo "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit."
        else
            break
        fi
    done

    new_encryption_password=$(echo "$new_password" | base64)

    if [[ "$new_email" == *"admin"* ]]; then
        role="admin"
    else
        role="user"
    fi

    echo "$new_email|$new_username|$new_security_question|$new_security_answer|$new_encryption_password|$role" >> users/users.txt

    echo "User $new_email added successfully"
}

edit_user() {
    user_info=$(grep "$edit_email" users/users.txt)
    if [[ -z $user_info ]]; then
        echo "User not found"
        return
    fi

    current_username=$(echo "$user_info" | cut -d '|' -f 2)
    current_security_question=$(echo "$user_info" | cut -d '|' -f 3)
    current_security_answer=$(echo "$user_info" | cut -d '|' -f 4)
    current_encryption_password=$(echo "$user_info" | cut -d '|' -f 5)

    read -p "Enter new username: " new_username
    if [[ -z "$new_username" ]]; then
        new_username="$current_username"
    fi

    read -p "Enter new security question: " new_security_question
    if [[ -z "$new_security_question" ]]; then
        new_security_question="$current_security_question"
    fi

    read -p "Enter new security answer: " new_security_answer
    if [[ -z "$new_security_answer" ]]; then
        new_security_answer="$current_security_answer"
    fi

    while true; do
        read -sp "Enter new password: " new_password
        echo
        if [[ ${#new_password} -lt 8 || !("$new_password" =~ [A-Z]) || !("$new_password" =~ [a-z]) || !("$new_password" =~ [0-9]) ]]; then
            echo "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit."
        else
            break
        fi
    done
    new_encryption_password=$(echo "$new_password" | base64)

    new_user_info=$(echo "$user_info" | sed "s/$current_username/$new_username/" | sed "s/$current_security_question/$new_security_question/" | sed "s/$current_security_answer/$new_security_answer/" | sed "s/$current_encryption_password/$new_encryption_password/")

    sed -i "s/$user_info/$new_user_info/" users/users.txt

    echo "User $edit_email edited successfully"
}

delete_user() {
    user_info=$(grep "$delete_email" users/users.txt)
    if [[ -z $user_info ]]; then
        echo "User not found"
        return
    fi

    sed -i "/$delete_email/d" users/users.txt

    echo "User $delete_email deleted successfully"
}

logout_admin() {
    echo "Exit"
    exit 0
}

    case $choice in
    a)      add_new_user
            ;;
    b)      read -p "Enter email of the user to edit: " edit_email
            edit_user
            ;;
    c)      read -p "Enter email of the user to delete: " delete_email
            delete_user
            ;;
    d)      logout_admin
            ;;
    *)      echo "Invalid choice"
            ;;
            
    esac
    
    else
        echo "Welcome, user!"
    fi
}
```

8. Fungsi untuk meminta password jika lupa password dengan memasukkan email yang sudah tersimpan pada bagian login menu
```bash
forgot_password() {
    read -p "Enter your email: " email
    user_info=$(grep "$email" users/users.txt)
    if [[ -z $user_info ]]; then
        echo "User not found"
        return
    fi
    read -p "Enter your security question: " security_question
    security_question=$(echo "$user_info" | cut -d '|' -f 3)
    read -p "Enter your security answer: " security_answer
    stored_security_answer=$(echo "$user_info" | cut -d '|' -f 4)
    
    if [[ "$security_answer" != "$stored_security_answer" ]]; then
        echo "Incorrect security answer"
        return
    fi
    encryption_password=$(echo "$user_info" | cut -d '|' -f 5 | base64 --decode)
    echo "Your password is: $encryption_password"
}
```

9. Fungsi untuk memilih menu pilihan yang ada pada login menu yang terdiri dari login, forgot password, dan exit.
```bash
login_menu() {
    echo "Select action:"
    echo "1. Login"
    echo "2. Forgot Password"
    echo "3. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)  login_user
            ;;
        2)  forgot_password
            ;;   
        3)  echo "Exiting..."
            exit 0
            ;:
        *)  echo "Invalid choice"
            login_menu
            ;;
    esac
}
login_menu
```

---
### **`Soal 3`**
Alyss adalah seorang gamer yang sangat menyukai bermain game Genshin Impact. Karena hobinya, dia ingin mengoleksi foto-foto karakter Genshin Impact. Suatu saat Yanuar memberikannya sebuah Link yang berisi koleksi kumpulan foto karakter dan sebuah clue yang mengarah ke penemuan gambar rahasia. Ternyata setiap nama file telah dienkripsi dengan menggunakan hexadecimal. Karena penasaran dengan apa yang dikatakan Yanuar, Alyss tidak menyerah dan mencoba untuk mengembalikan nama file tersebut kembali seperti semula.

a. Alyss membuat script bernama awal.sh, untuk download file yang diberikan oleh Yanuar dan unzip terhadap file yang telah diunduh dan decode setiap nama file yang terenkripsi dengan hex . Karena pada file list_character.csv terdapat data lengkap karakter, Alyss ingin merename setiap file berdasarkan file tersebut. Agar semakin rapi, Alyss mengumpulkan setiap file ke dalam folder berdasarkan region tiap karakter. `i. Format: Region - Nama - Elemen - Senjata.jpg`

b. Karena tidak mengetahui jumlah pengguna dari tiap senjata yang ada di folder "genshin_character".Alyss berniat untuk menghitung serta menampilkan jumlah pengguna untuk setiap senjata yang ada. `i. Format: [Nama Senjata]:[jumlah]`
Untuk menghemat penyimpanan. Alyss menghapus file - file yang tidak ia gunakan, yaitu genshin_character.zip, list_character.csv, dan genshin.zip

c. Namun sampai titik ini Alyss masih belum menemukan clue dari the secret picture yang disinggung oleh Yanuar. Dia berpikir keras untuk menemukan pesan tersembunyi tersebut. Alyss membuat script baru bernama search.sh untuk melakukan pengecekan terhadap setiap file tiap 1 detik. Pengecekan dilakukan dengan cara meng-ekstrak sebuah value dari setiap gambar dengan menggunakan command steghide. Dalam setiap gambar tersebut, terdapat sebuah file txt yang berisi string. Alyss kemudian mulai melakukan dekripsi dengan hex pada tiap file txt dan mendapatkan sebuah url. Setelah mendapatkan url yang ia cari, Alyss akan langsung menghentikan program search.sh serta mendownload file berdasarkan url yang didapatkan.

d. Dalam prosesnya, setiap kali Alyss melakukan ekstraksi dan ternyata hasil ekstraksi bukan yang ia inginkan, maka ia akan langsung menghapus file txt tersebut. Namun, jika itu merupakan file txt yang dicari, maka ia akan menyimpan hasil dekripsi-nya bukan hasil ekstraksi. Selain itu juga, Alyss melakukan pencatatan log pada file image.log untuk setiap pengecekan gambar
`i. Format: [date] [type] [image_path]`
```
Ex:
1. [24/03/20 17:18:19] [NOT FOUND] [image_path]
2. [24/03/20 17:18:20] [FOUND] [image_path]
```
#### > Isi Soal

#### > Penyelesaian

#### > Penjelasan

#### > Dokumentasi

#### > Revisi
---
### **`Soal 4`**
`> Hazwan`

#### > Isi Soal
Stitch sangat senang dengan PC di rumahnya. Suatu hari, PC nya secara tiba-tiba nge-freeze 🤯 Tentu saja, Stitch adalah seorang streamer yang harus setiap hari harus bermain game dan streaming.  Akhirnya, dia membawa PC nya ke tukang servis untuk diperbaiki. Setelah selesai diperbaiki, ternyata biaya perbaikan sangat mahal sehingga dia harus menggunakan uang hasil tabungan nya untuk membayarnya. Menurut tukang servis, masalahnya adalah pada CPU dan GPU yang overload karena gaming dan streaming sehingga mengakibatkan freeze pada PC nya. Agar masalah ini tidak terulang kembali, Stitch meminta kamu untuk membuat sebuah program monitoring resource yang tersedia pada komputer.

Buatlah program monitoring resource pada PC kalian. Cukup monitoring ram dan monitoring size suatu directory. Untuk ram gunakan command `free -m`. Untuk disk gunakan command `du -sh <target_path>`. Catat semua metrics yang didapatkan dari hasil `free -m`. Untuk hasil `du -sh <target_path>` catat size dari path directory tersebut. Untuk target_path yang akan dimonitor adalah /home/{user}/. 

- Masukkan semua metrics ke dalam suatu file log bernama metrics_{YmdHms}.log. {YmdHms} adalah waktu disaat file script bash kalian dijalankan. Misal dijalankan pada 2024-03-20 15:00:00, maka file log yang akan tergenerate adalah metrics_20240320150000.log. 
- Script untuk mencatat metrics diatas diharapkan dapat berjalan otomatis pada setiap menit. 
- Kemudian, buat satu script untuk membuat agregasi file log ke satuan jam. Script agregasi akan memiliki info dari file-file yang tergenerate tiap menit. Dalam hasil file agregasi tersebut, terdapat nilai minimum, maximum, dan rata-rata dari tiap-tiap metrics. File agregasi akan ditrigger untuk dijalankan setiap jam secara otomatis. Berikut contoh nama file hasil agregasi metrics_agg_2024032015.log dengan format metrics_agg_{YmdH}.log 
- Karena file log bersifat sensitif pastikan semua file log hanya dapat dibaca oleh user pemilik file. 

**Note:**
- Nama file untuk script per menit adalah minute_log.sh
- Nama file untuk script agregasi per jam adalah aggregate_minutes_to_hourly_log.sh
- Semua file log terletak di /home/{user}/log
- Semua konfigurasi cron dapat ditaruh di file skrip .sh nya masing-masing dalam bentuk comment

**Berikut adalah contoh isi dari file metrics yang dijalankan tiap menit:**
mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size 
15949,10067,308,588,5573,4974,2047,43,2004,/home/user/coba/,74M

**Berikut adalah contoh isi dari file aggregasi yang dijalankan tiap jam:**
type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size 
minimum,15949,10067,223,588,5339,4626,2047,43,1995,/home/user/coba/,50M 
maximum,15949,10387,308,622,5573,4974,2047,52,2004,/home/user/coba/,74M 
average,15949,10227,265.5,605,5456,4800,2047,47.5,1999.5,/home/user/coba/,62M

#### > Penyelesaian
**minute_log.sh**
```bash
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
```
**aggregate_minutes_to_hourly_log.sh**
```bash
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
```

#### > Penjelasan
Pada soal, kami diminta untuk membuat program monitoring resource pada PC untuk RAM dan Size suatu directory dengan menggunakan `free -m` untuk RAM dan `du -sh` untuk disk.

- Masukkan semua metrics ke dalam suatu file log bernama metrics_{YmdHms}.log. {YmdHms} adalah waktu disaat file script bash kalian dijalankan. Misal dijalankan pada 2024-03-20 15:00:00, maka file log yang akan tergenerate adalah metrics_20240320150000.log. Untuk menyelesaikan poin tersebut, yang kita lakukan adalah mengisi ini yaitu membuat shell script bernama `minute_log.sh` lalu mengisinya dengan:
```
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
```
1. **Menetapkan Tanggal dan Waktu:**
    - `datetime=$(date "+%Y%m%d%H%M%S")`
    - Baris ini menggunakan perintah `date` untuk mendapatkan tanggal dan waktu saat ini dalam format `YYYYMMDDHHMMSS`. Hasilnya disimpan dalam variabel `datetime`.

2. **Mengumpulkan Metrik Sistem:**
    - `metrics=$(free -m | awk 'NR==2 {printf "%s,%s,%s,%s,%s,%s", $2, $3, $4, $5, $6, $7}')`
    - Perintah `free -m` mengambil statistik penggunaan memori dalam megabita.
    - Perintah `awk` memproses baris kedua output (yang berisi data penggunaan memori aktual) dan mencetak bidang-bidang tertentu (total memori, memori terpakai, memori bebas, memori bersama, memori buffer, dan memori cache) yang dipisahkan oleh koma. Hasilnya disimpan dalam variabel `metrics`.

3. **Menetapkan Jalur Log:**
    - `path="/home/$(whoami)/sisop/modul1/soal4/log/minute/"`
    - Baris ini mendefinisikan jalur di mana file log akan disimpan. Ini mencakup direktori rumah pengguna saat ini dan struktur direktori yang spesifik.

4. **Menghitung Ukuran Jalur:**
    - `path_size=$(du -sh $path | awk '{print $1}')`
    - Perintah `du -sh` menghitung total ukuran direktori yang ditentukan (`$path`) dalam format yang mudah dibaca manusia (misalnya "10M" untuk 10 megabita).
    - Perintah `awk` mengekstrak nilai ukuran (bidang pertama) dari output `du` dan menyimpannya dalam variabel `path_size`.

5. **Mengumpulkan Informasi Ruang Swap:**
    - `swap_total=$(free | awk 'NR==3 {print $2}')`
    - `swap_used=$(free | awk 'NR==3 {print $3}')`
    - `swap_free=$(free | awk 'NR==3 {print $4}')`
    - Baris-baris ini menggunakan perintah `free` untuk mengambil informasi tentang ruang swap (memori virtual).
    - Perintah `awk` mengekstrak nilai-nilai yang relevan (total ruang swap, ruang swap terpakai, dan ruang swap bebas) dari baris ketiga output `free` dan mengassignnya ke variabel yang sesuai.

6. **Membuat dan Menulis ke File Log:**
    - `echo "$metrics,$swap_total,$swap_used,$swap_free,$path,$path_size" > /home/$(whoami)/sisop/modul1/soal4/log/minute/metrics_${datetime}.log`
    - Baris ini menggabungkan entri log dengan menggabungkan metrik yang dikumpulkan, informasi ruang swap, jalur, dan ukuran jalur.
    - String hasilnya ditulis ke file log bernama `metrics_<datetime>.log`, di mana `<datetime>` mewakili tanggal dan waktu saat ini.

- Script untuk mencatat metrics diatas diharapkan dapat berjalan otomatis pada setiap menit. Untuk mengerjakan poin ini, kami melakukan crontab lalu melakukan konfigurasi.
```
crontab -e
* * * * * /home/zwaneee/sisop/modul1/soal4/log/minute/minute_log.sh
```
`Kami melakukan hal tersebut adalah untuk membuat script minute_log.sh akan berjalan otomatis setiap menitnya atau dalam artian lain, akan mencetak file.log yang diminta soal setiap menit.`

- Kemudian, buat satu script untuk membuat agregasi file log ke satuan jam. Script agregasi akan memiliki info dari file-file yang tergenerate tiap menit. Dalam hasil file agregasi tersebut, terdapat nilai minimum, maximum, dan rata-rata dari tiap-tiap metrics. File agregasi akan ditrigger untuk dijalankan setiap jam secara otomatis. Berikut contoh nama file hasil agregasi metrics_agg_2024032015.log dengan format metrics_agg_{YmdH}.log
```
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
```

1. **Menetapkan Tanggal dan Waktu:**
    - `datetime=$(date "+%Y%m%d%H")`
    - Baris ini menggunakan perintah `date` untuk mendapatkan tanggal dan waktu saat ini dalam format `YYYYMMDDHH`. Hasilnya disimpan dalam variabel `datetime`.

2. **Menetapkan Direktori Log:**
    - `log_directory="/home/$(whoami)/sisop/modul1/soal4/log/minute/"`
    - Baris ini mendefinisikan jalur di mana file log per menit akan disimpan.

3. **Menetapkan Direktori Output:**
    - `output_directory="/home/$(whoami)/sisop/modul1/soal4/log/hour/"`
    - Baris ini mendefinisikan jalur di mana file log agregat per jam akan disimpan.

4. **Mengumpulkan Data Log:**
    - Kita mencari semua file log yang sesuai dengan pola "metrics_*.log" dalam direktori log per menit.
    - Setiap baris dalam file log berisi informasi tentang penggunaan memori, ruang swap, dan ukuran direktori.
    - Data-data ini disimpan dalam array `dir_sizes`.

5. **Mengurutkan Ukuran Direktori:**
    - Array `dir_sizes` diurutkan berdasarkan ukuran direktori (kolom ke-11).
    - Nilai terkecil dan terbesar disimpan dalam variabel `min_size` dan `max_size`.

6. **Menghitung Rata-rata:**
    - Kita menghitung rata-rata dari setiap kolom (kecuali path size) antara nilai terkecil dan terbesar.
    - Jika hasilnya bilangan bulat, kita hapus desimalnya.
    - Hasil rata-rata disimpan dalam array `avg_arr`.

7. **Menghitung Ukuran Path Rata-rata:**
    - Kita menghitung rata-rata ukuran path (dalam kilobita) antara nilai terkecil dan terbesar.
    - Jika hasilnya bilangan bulat, kita tambahkan "K" di akhirnya.
    - Hasil ukuran path rata-rata disimpan dalam variabel `avg_path_size`.

8. **Menyusun Baris Hasil Rata-rata:**
    - Kita menggabungkan semua nilai rata-rata dalam satu baris dengan memisahkannya dengan koma.
    - Baris ini disimpan dalam variabel `avg_line`.

9. **Menyimpan Hasil ke File Output:**
    - Hasil minimum, maksimum, dan rata-rata disimpan dalam file log agregat per jam.
    - File ini diberi nama `metrics_agg_<datetime>.log`, di mana `<datetime>` mewakili tanggal dan waktu saat ini.

`logika yang saya gunakan diatas adalah mengumpulkan setiap metrik.log yang dihasilkan setiap menit ke dalam sebuah array, yang dimana di dalam array tersebut kita dapat melakukan sorting untuk menemukan value minimum, maximum dan average`

- Tambahkan juga konfigurasi `crontab` pada shell script yang setiap jam.
```
crontab -e
0 * * * * /home/zwaneee/sisop/modul1/soal4/log/hour/aggregate_minutes_to_hourly_log.sh
```
`Kami melakukan hal tersebut adalah untuk membuat script aggregate_minutes_to_hourly_log.sh akan berjalan otomatis setiap jamnya atau dalam artian lain, akan mencetak file.log yang diminta soal setiap jam.`

- Karena file log bersifat sensitif pastikan semua file log hanya dapat dibaca oleh user pemilik file. Untuk melengkapi poin ini sangat simple kita hanya perlu menggunakan `chmod 600`
> `chmod 600 /home/$(whoami)/sisop/modul1/soal4/log/minute/metrics_${datetime}.log`

> `chmod 600 /home/$(whoami)/sisop/modul1/soal4/log/hour/metrics_agg${datetime}.log`

kami hanya perlu menambahkan command tersebut ke setiap shell script yang kami buat diatas.

#### > Dokumentasi
<img width="1420" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/770f700a-439d-4af7-b6d4-4c55d1d8a98e">
<img width="1422" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/4399a492-0813-41bc-b833-2a3130dcd386">
<img width="1421" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/00f77b5f-9be6-4acb-8e13-bb48f8661480">
<img width="937" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/b2f0be85-2fca-4215-8612-d568ddf1b369">
<img width="1420" alt="image" src="https://github.com/HazwanAdhikara/Sisop-1-2024-MH-IT13/assets/151142830/f9aee549-d01b-4d78-9c82-646e5181e547">

---
