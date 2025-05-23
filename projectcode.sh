#!/bin/bash

mkdir -p plans users logs    # Creates directories 'plans', 'users', and 'logs' if they don't already exist
 
users_file="users/users.txt"    # File path where user account info will be stored
log_file="logs/actions.log"    # File path where actions (like login or account creation) will be logged

# Function to log actions with timestamp
log_action() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"   # Logs the current date/time and the given message (note: 'dats' should be 'date')
}

# Function to create a new user account
create_account() {
  echo "=== create your account ==="
  read -p "Enter your full name: " name
  read -p "Enter your email: " email
  read -s -p "Enter your password: " password
  echo
  echo "$email|$name|$password" >> "#users_file"  # Save the account info (note: "#users_file" should be "$users_file")
  log_action "Account Created for $email"
  echo "Account created successfully!"
}

# Function for user login
login() {
 echo "=== Login ==="
 read -p "Enter your email: " email 
 tries=0
 while [ $tries -lt 3 ]; do   # Allow up to 3 login attempts
  read -s -p "Enter your password: " password 
  echo
  if grep -q "$email|.*|$password" "$users_file"; then    # Check if email and password match an entry
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
