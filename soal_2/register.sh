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
