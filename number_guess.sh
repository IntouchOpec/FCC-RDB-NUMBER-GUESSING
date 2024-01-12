#!/bin/bash
MIN_GUESS_NUMBER=1
MAX_GUESS_NUMBER=1000
SECRET_NUMBER=$((RANDOM % ($MAX_GUESS_NUMBER - $MIN_GUESS_NUMBER + 1) + $MIN_GUESS_NUMBER))
echo -e "Enter your username: "
read USERNAME_INPUT 
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"
USERS=$($PSQL "SELECT user_id, username FROM users WHERE username = '$USERNAME_INPUT'; ")

function GUESSING_GAME() {
  read GUESS_NUMBER_INPUT
  if  [[ ! "$GUESS_NUMBER_INPUT" =~ ^[0-9]+$ ]]; 
  then
    echo -e "That is not an integer, guess again:"
    GUESSING_GAME 
  fi
  if [ $SECRET_NUMBER -lt $GUESS_NUMBER_INPUT ];
  then
    echo "It's higher than that, guess again:"
    GUESSING_GAME 
  fi
  if [ $SECRET_NUMBER -gt $GUESS_NUMBER_INPUT ];
  then 
    echo -e "It's lower than that, guess again:" 
    GUESSING_GAME
  fi
  return $GUESS_NUMBER_INPUT
}

if [[ -z $USERS ]]
then 
  echo -e "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
else 
  echo -e "Welcom back, $USERNAME_INPUT! You have play $NUMBER_OF_GUESS games, and your best game took $BEST_GAME guesses"
fi
echo "Guess the secret number between 1 and 1000:"
GUESSING_GAME 