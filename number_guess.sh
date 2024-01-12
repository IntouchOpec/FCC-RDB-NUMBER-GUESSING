#!/bin/bash
MIN_GUESS_NUMBER=1
MAX_GUESS_NUMBER=1000
GUESS_NUMBER=$((RANDOM % ($MAX_GUESS_NUMBER - $MIN_GUESS_NUMBER + 1) + $MIN_GUESS_NUMBER))
echo -e "Enter your username: "
read USERNAME_INPUT 
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

GUESS=$($PSQL "SELECT guess_id, username FROM guesses WHERE username = '$USERNAME_INPUT'; ")

if [[ -z $GUESS ]]
then 
  echo -e "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
  echo -e "Guesss the secret number between 1 and 1000:"
else 
  echo -e "Welcom back, $USERNAME_INPUT! You have play $NUMBER_OF_GUESS games, and your best game took $BEST_GAME guesses"
fi
