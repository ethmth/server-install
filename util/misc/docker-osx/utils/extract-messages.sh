#!/bin/bash

HOST="127.0.0.1"
username="user"
password="alpine"

sshpass -p "$password" scp -r -o StrictHostKeyChecking=no -P 50922 $username@$HOST:/Users/$username/Desktop/Messages ./