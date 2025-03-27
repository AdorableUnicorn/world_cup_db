#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WIN_GOALS OPP_GOALS
do

if [[ $YEAR != 'year' ]]
then

WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")

if [[ -z $WINNER_ID ]]
then

WINNER_INS=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
echo "$WINNER_ID is entered correctly, WINNER"

fi

if [[ -z $OPPONENT_ID ]]
then

OPPONENT_INS=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
echo "$OPPONENT_ID is entered correctly, OPPONENT"

fi

if [[ -z $WINNER_ID || -z $OPPONENT_ID ]] 
then

echo "Something if wrong. $WINNER_ID SHIT $OPPONENT_ID"

else

INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WIN_GOALS, $OPP_GOALS);")
echo "$YEAR game has been inserted"
fi

fi

done
