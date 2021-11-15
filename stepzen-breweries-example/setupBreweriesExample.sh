#!/bin/bash

APIKEY=$1

gcloud sql instances create demopg --database-version=POSTGRES_13 --memory=4096MB --cpu=2 --region=us-central

gcloud sql databases create breweries --instance=demopg

echo "Now we're going to ask you to enter a password for postgres. Choose carefully"

stty -echo
PASS2=notequal
while [ "$PASS" != "$PASS2" ]
do
    echo Please enter your password
    read PASS
    echo Please re-enter your password
    read PASS2
done
stty echo

gcloud sql users set-password postgres --instance=demopg --password=$PASS

echo "start cloud_sql_proxy in another window and then get back here. Command below"
echo 'cloud_sql_proxy -instances=$(gcloud sql instances describe demopg | grep connectionName | cut -d" " -f2)=tcp:5432'
echo
echo "Waiting. Hit <CR> to continue"
read foo

echo "Now we're going to run the script. We will reuse your password you set above here to make the connection"
PGPASSWORD=$PASS psql "host=127.0.0.1 sslmode=disable dbname=breweries user=postgres" -f breweries.sql

echo "Setting network access"
gcloud sql instances patch demopg --authorized-networks=34.68.67.42/32


PORT=5432
HOST=$(gcloud sql instances describe demopg | grep connectionName | cut -d" " -f2)

echo "Updating config"
cp stepzen/config.yaml.sample stepzen/config.yaml
sed -i -e "s/@%PASS%@/$PASS/" -e "s/@%PORT%@/5432/" -e "s/@%HOST%@/$HOST/" -e "s/@%APIKEY%@/$APIKEY/" stepzen/config.yaml
