#!/bin/bash
set -e

./initdb.sh
echo "Launching database initialization"
docker-compose up -d db
# Because it's faster
sleep 120
echo "Launching init service"
docker-compose up -d superset-init
sleep 120
echo "Launching all services"
docker-compose up -d
echo "Services launched"
echo "Adding new data to database"
echo "New data added"

echo "Adding default datasources"
sleep 80
docker cp dist/dexter.json superset_app:/app/
docker cp dist/datasources.yaml superset_app:/app/
docker-compose exec superset superset import_datasources -p /app/datasources.yaml
echo "Imported default datasources"
echo "Adding default dashboard"
docker-compose exec superset superset import_dashboards -p /app/dexter.json
# Bug : https://github.com/apache/superset/issues/8395
docker-compose exec superset superset set_database_uri -d Insee -u postgresql+psycopg2://superset:superset@db:5432/mortalite_insee
echo "Imported default dashboard"
IP=`curl -s ipecho.net/plain`
echo
echo "You can access the dashboard at http://$IP:8088/superset/dashboard/1/"
echo "user/pass : admin/admin (you should change those)"
