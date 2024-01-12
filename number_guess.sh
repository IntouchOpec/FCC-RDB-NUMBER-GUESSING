#!/bin/bash
MIN_GUESS_NUMBER=1
MAX_GUESS_NUMBER=1000
GUESS_NUMBER=$((RANDOM % ($MAX_GUESS_NUMBER - $MIN_GUESS_NUMBER + 1) + $MIN_GUESS_NUMBER))
echo -e "Enter your username: "
read USERNAME_INPUT 
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"
