#!/bin/bash

FLYWAY_HOME="/opt/flyway-10.5.0/"
function prop {
    flyway_prop=$2
    grep "^${1}" "$flyway_prop"|cut -d'=' -f2
}

operation=$1
echo "Select a Database to execute migration"
echo "1. Dev"
read db_selected
echo $db_selected

case $db_selected in
  1)
  directory=dev
    ;;
  *)
    echo "Default condition executed"
    ;;
  esac

  flyway_location="$directory/flyway.conf"
  echo $flyway_location
# schema=$(prop "flyway.schema" $flyway_location)
user=$(prop "flyway.user" $flyway_location)
password=$(prop "flyway.password" $flyway_location)
url=$(prop "flyway.url" $flyway_location)

echo "Running migration on the file"
$FLYWAY_HOME/flyway -user=$user -password=$password -url=$url -placeholders.abc=def migrate -locations=$directory/scripts