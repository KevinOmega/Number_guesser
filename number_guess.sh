#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align --tuples-only -c"

TEST=$($PSQL "SELECT * FROM users")
echo "$TEST"