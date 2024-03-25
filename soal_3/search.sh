#!/bin/bash

is_url() {
    url="$1"
    if [[ "$url" =~ ^https?:// ]]; then
        return 0
    else
        return 1
    fi
}

log_entry() {
    log_date=$(date +"%Y-%m-%d %T")
    echo "[$log_date] $1 $2" >> image.log
}

while true; do
    for image_file in genshin_character/*/*.jpg; do
        log_entry "INFO" "Checking $image_file"
        
        hidden_value=$(steghide extract -sf "$image_file" -p "" 2>/dev/null)
        
if [[ $? -eq 0 && ! -z "$hidden_value" ]]; then
    decrypted_value=$(echo "$hidden_value" | xxd -r -p)
    
    if is_url "$decrypted_value"; then
        log_entry "INFO" "URL found: $decrypted_value"
        
        wget -O secret_file.txt "$decrypted_value"

        exit 0
    fi
    
    log_entry "INFO" "Hidden value extracted successfully: $decrypted_value"
else
    log_entry "WARNING" "Extraction failed or no hidden value found in $image_file"

    rm -f secret_file.txt
fi

    done
    
    sleep 1
done
