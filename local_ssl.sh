#!/bin/bash
#.zshrc 기준 

setup_ssl() {
    echo "PLZ wirte keyname.."
    echo "keyname : "
    local key_name=$1
    local pub_key_name=pub-$key_name
    local ca_name=$key_name"CA"

    echo "openssl install..."
    brew install openssl
    echo "😃 Done"

    echo "personal key and public key create..."
    openssl genrsa -out $key_name.key 2048
    openssl rsa -in $key_name.key -pubout -out $pub_key_name.key
    echo "😃 Done"

    echo "CSR create..."
    openssl req -new -key $key_name.key -out $key_name.csr
    echo "😃 Done"

    echo "CA create..."
    openssl genrsa -aes256 -out $ca_name.key 2048
    openssl req -x509 -new -nodes -key $ca_name.key -days 3650 -out $ca_name.pem
    openssl x509 -req -in $key_name.csr -CA $ca_name.pem -CAkey $ca_name.key -CAcreateserial -out $key_name.crt -days 3650
    echo "😃 Done"
}

echo "Command_List : ssl"

command=$1
echo "=== LOCAL SSL SETUP! ==="
echo "========================"
echo $command
if [[ $command == "ssl" ]]; then
    setup_ssl
else
    echo "else!"
fi

echo "========================"
echo "END! Enjoy your programming!"
