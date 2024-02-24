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
  else
    NUMBER_OF_GAMES=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
    MAX_SCORE=$($PSQL "SELECT MAX(guesses) FROM games WHERE user_id=$USER_ID")
    echo "Welcome back, $USERNAME! You have played $NUMBER_OF_GAMES games, and your best game took $MAX_SCORE guesses."
  fi
  #if user exist
}

main