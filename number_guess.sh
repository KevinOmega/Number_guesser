#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align --tuples-only -c"

RANDOM_NUMBER=$(( 1 + $RANDOM % 1000 ))
echo $RANDOM_NUMBER