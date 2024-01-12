#!/bin/bash
MIN_GUESS_NUMBER=1
MAX_GUESS_NUMBER=1000
SECRET_NUMBER=$((RANDOM % ($MAX_GUESS_NUMBER - $MIN_GUESS_NUMBER + 1) + $MIN_GUESS_NUMBER))
echo -e "Enter your username: "
read USERNAME_INPUT 
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"
USERS=$($PSQL "SELECT user_id, username, toltal_number_of_games, fewest_number_of_guesses FROM users WHERE username = '$USERNAME_INPUT'; ")

COUNT_GUESS=$(1)

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
  COUNT_GUESS=$(($COUNT_GUESS+1))
  return $GUESS_NUMBER_INPUT
}

if [[ -z $USERS ]]
then 
  echo -e "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users (username, toltal_number_of_games, fewest_number_of_guesses) VALUES ('$USERNAME_INPUT',0,0);")
else 
  echo "$USERS" | while read USER_ID BAR USERNAME BAR TOLTAL_NUMBER_OF_GAMES BAR FEWEST_NUMBER_OF_GUESSES
    do
      echo -e "Welcome back, $USERNAME_INPUT! You have played $TOLTAL_NUMBER_OF_GAMES games, and your best game took $FEWEST_NUMBER_OF_GUESSES guesses."
    done
fi

echo "Guess the secret number between 1 and 1000:"
GUESSING_GAME 
if [ $SECRET_NUMBER -eq $GUESS_NUMBER_INPUT ];
then
  if [[ $FEWEST_NUMBER_OF_GUESSES -lt $COUNT_GUESS ]]
  then
      FEWEST_NUMBER_OF_GUESSES=$(($COUNT_GUESS + 1))
  fi 
  TOLTAL_NUMBER_OF_GAMES=$(($TOLTAL_NUMBER_OF_GAMES + 1))
  UPDATED_USER_RESULT=$($PSQL "UPDATE users SET toltal_number_of_games = $TOLTAL_NUMBER_OF_GAMES, fewest_number_of_guesses = $FEWEST_NUMBER_OF_GUESSES WHERE username = '$USERNAME_INPUT';")
fi