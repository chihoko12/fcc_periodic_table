#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# input validation
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# Determine the type of the input and create the appropriate SQL query
if [[ $1 =~ ^[0-9]+$ ]]
then
  RESULT=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e INNER JOIN properties p ON e.atomic_number = p.atomic_number INNER JOIN types t ON p.type_id = t.type_id WHERE e.atomic_number = $1;")
elif [[ $1 =~ ^[a-zA-Z]+$ ]]
then
#else
  RESULT=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e INNER JOIN properties p ON e.atomic_number = p.atomic_number INNER JOIN types t ON p.type_id = t.type_id WHERE e.symbol = '$1' OR e.name = '$1';")
else
  echo "I could not find that element in the database."
  exit
fi

if [[ -z $RESULT ]]
then
  echo "I could not find that element in the database."
  exit
fi

# Extracting the fields from the result
IFS='|' read -r atomic_number symbol name atomic_mass melting_point_celsius boiling_point_celsius type <<< "$RESULT" 

# Output the details
echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."