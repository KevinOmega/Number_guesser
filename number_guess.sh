#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align --tuples-only -c"

main(){
  RANDOM_NUMBER=$(( 1 + $RANDOM % 1000 ))
  echo "Enter your username:"
  read USERNAME
  #check if username exist
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
  #if user does not exist
  if [[ -z $USER_ID ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    USER_ID=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME') RETURNING user_id")
    echo $USER_ID
  else
    echo "Already exist"
  fi
  #if user exist
}

main