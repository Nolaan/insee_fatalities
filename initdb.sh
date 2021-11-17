#!/bin/bash
set -e

SQLFILE=insee.sql
cd ./dist
# vvvvvvv IMPORTANT vvvvvvv
echo "Creating database file..."
cat *.tar.gz > dump.tar.bz2
tar --no-same-permissions -xjf dump.tar.bz2
echo "Database file created."
rm -f dump.tar.bz2
echo "Temporary zip file deleted."
sed -i '1i\\\c mortalite_insee;' $SQLFILE # this is a hack!
sed -i '1i\CREATE DATABASE mortalite_insee OWNER superset;' $SQLFILE # this is a hack!
#createdb -O superset mortalite_insee
#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "mortalite_insee" -f $SQLFILE
