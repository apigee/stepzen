# Breweries sample
This sample builds on the first by also proxying for:

1. Cloud SQL
1. Maps API

## Prereqs 
You'll need the following:
* gcloud
* psql
* a google maps api key

You will use the same install script located in the root but will need to get your cloudsql database
setup first. We've provided a script that will walk you through this setup.

But before executing this you will need to create a google maps API Key and then pass that as the first
and only argument to the script

Additionally, you will need to ensure that you have installed the psql client and the cloud_sql_proxy
which will enable you to connect to your provisioned database via a secure tunnel.

With those setup simply execute the following which will walk you through the rest of the setup

```bash
./setupBreweriesExample.sh <your_maps_apikey>

```
