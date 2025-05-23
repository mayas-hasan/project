#!/bin/bash

mkdir -p plans users logs

users_file="users/users.txt"
log_file="logs/actions.log"

log_action() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"
}

create_account() {
  echo "=== create your account ==="
  read -p "Enter your full name: " name
  read -p "Enter your email: " email
  read -s -p "Enter your password: " password
  echo
  echo "$email|$name|$password" >> "#users_file"
  log_action "Account Created for $email"
  echo "Account created successfully!"
}

login() {
 echo "=== Login ==="
 read -p "Enter your email: " email 
 tries=0
 while [ $tries -lt 3 ]; do
  read -s -p "Enter your password: " password 
  echo
  if grep -q "$email|.*|$password" "$users_file"; then 
  echo "Login successful. Welcome!"
  log_action "$email logged in"
  return 0
 else 
  echo "Incorrect password. Try again."
  ((tries++))
  fi
 done 
 echo "Too many failed attempts. Exiting..."
 log_action "Failed login attempt for $email"
 exit 1
}
