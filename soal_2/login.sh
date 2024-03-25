#!/bin/bash

login_user() {
    read -p "Enter your email: " email
    read -sp "Enter your password: " password
    echo " "

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
