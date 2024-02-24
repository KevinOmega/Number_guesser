#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align --tuples-only -c"


main(){
  RANDOM_NUMBER=$(( 1 + $RANDOM % 1000 ))
  echo "Enter your username:"
  read USERNAME
  #check if username exist
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
  if [[ -z $USER_ID ]]
  then
    #if user does not exist
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    INSERT_USERS_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
  else
    #if user exist
    NUMBER_OF_GAMES=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
    MAX_SCORE=$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id=$USER_ID")
    echo "Welcome back, $USERNAME! You have played $NUMBER_OF_GAMES games, and your best game took $MAX_SCORE guesses."
  fi
  echo "Guess the secret number between 1 and 1000:"
  
  GUESSED=0
  while [[ $GUESSED == 0 ]]
  do
    read NUMBER
    GUESSES=$(($GUESSES+1))
    if [[ $NUMBER == $RANDOM_NUMBER  ]]
    then
      GUESSED=1
    elif [[ ! $NUMBER =~ ^[0-9]+$ ]]
    then
      echo "That is not an integer, guess again:"
    elif [[ $NUMBER > $RANDOM_NUMBER ]]
    then
      echo "It's lower than that, guess again:"
    else
      echo "It's higher than that, guess again:"
    fi
  done
  INSERT_DATA=$($PSQL "INSERT INTO games(user_id,guesses) VALUES($USER_ID,$GUESSES)")
  echo "You guessed it in $GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"
}

main