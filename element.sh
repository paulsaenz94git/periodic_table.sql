PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


INPUT=$1

if [[ -z $1 ]]
  then
    echo Please provide an element as an argument.
  else
    # if INPUT is not atomic_number
if [[ ! $INPUT =~ ^[0-9]+$ ]]
  then
    LENGHT=$(echo -n "$INPUT" | wc -m)

    # if INPUT is element name
    if [[ $LENGHT >2 ]]
      then
        DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name = '$INPUT'")
        if [[ -z $DATA ]]
          then
            echo "I could not find that element in the database."
          else
            echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
            do
              echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
            done
        fi
    
      # if INPUT is element symbol
      else
        DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol = '$INPUT'")
        if [[ -z $DATA ]]
          then
            echo "I could not find that element in the database."
          else
            echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
              do
            echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
            done
        fi
    fi
  
  # if INPUT is atomic_number
  else
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number = $INPUT")
    if [[ -z $DATA ]]
          then
            echo "I could not find that element in the database."
          else
            echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
            do
              echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
            done
      fi

fi
fi



