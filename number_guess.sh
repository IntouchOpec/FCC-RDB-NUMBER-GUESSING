#!/bin/bash
MIN_GUESS_NUMBER=1
MAX_GUESS_NUMBER=1000
GUESS_NUMBER=$((RANDOM % ($MAX_GUESS_NUMBER - $MIN_GUESS_NUMBER + 1) + $MIN_GUESS_NUMBER))
echo -e "Enter your username: "
read USERNAME_INPUT 
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

GUESS=$($PSQL "SELECT guess_id, username FROM guesses WHERE username = '$USERNAME_INPUT'; ")

function VAlIDATE_SECRET_NUMBER() {
  echo $1
  read SECRET_NUMBER
  if  [[ ! "$SECRET_NUMBER" =~ ^[0-9]+$ ]]; 
  then
    VAlIDATE_SECRET_NUMBER "That is not an integer, guess again:"
  fi
  if [ $SECRET_NUMBER -lt $MIN_GUESS_NUMBER ];
  then
    VAlIDATE_SECRET_NUMBER "It's lower than that, guess again:" 
  fi
  if [ $SECRET_NUMBER -gt $MAX_GUESS_NUMBER ];
  then 
    VAlIDATE_SECRET_NUMBER "It's higher than that, guess again:"
  fi
  return $SECRET_NUMBER
}


if [[ -z $GUESS ]]
then 
  echo -e "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
  VAlIDATE_SECRET_NUMBER "Guess the secret number between 1 and 1000:"
  echo $SECRET_NUMBER
else 
  echo -e "Welcom back, $USERNAME_INPUT! You have play $NUMBER_OF_GUESS games, and your best game took $BEST_GAME guesses"
fi
