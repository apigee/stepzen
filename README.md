# Google Apigee-StepZen Demo
This repo contains a script that makes it easy to quickly spin up a StepZen hosted GraphQL endpoint fronted
with an Apigee depoyed Proxy (Apigee Hybrid or Apigee X)

## Prereqs
* existing Apigee X or Apigee Hybrid org 
* gcloud
* nodejs (for the execution of the script)
 ** including npm or yarn

## Setting it all up
The whole setup is fully automated and as simple as running the following:
```bash
# Make sure our dependencies are installed
npm i # or yarn if you prefer

# now lets run the script proper
./apizenSetup -o geirs-purdy-project -n sz -e test1 -t $(gcloud auth print-access-token) -i $(gcloud auth print-identity-token) -z
```

## Testing the setup
Once this finishes you should see your apigee api key outputed on the screen. Copy that key and execute a curl command like so:

```bash
curl -X POST 'https://<hostname>/graphql/stepzample?apikey=<your_api_key>' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' --data-binary '{"query":"{\n  location(ip: \"8.8.8.8\") {\n    as\n    city\n    continent\n    country\n    countryCode\n  }\n}","variables":{}}' --compressed
```

That will ouptut the following:
```json
{
	"data": {
		"location": {
			"as": "AS15169 Google LLC",
			"city": "Ashburn",
			"continent": "North America",
			"country": "United States",
			"countryCode": "US"
		}
	}
}
```

## Other schemas
There are some other schemas available. 

### Breweries example
The [breweries example](stepzen-breweries-example) includes a StepZen schema that proxies for a db
located in cloudsql. There's a separate readme there to get the backends setup and ready.

Once that's setup you can execute the same script from above to load this sample.

```bash
./apizenSetup -o geirs-purdy-project -n sz -e test1 -t $(gcloud auth print-access-token) -i $(gcloud auth print-identity-token) -m breweries -S stepzen-breweries-example
```

Here we've added an argument for the path to the breweries-schema setup plus set the model name to breweries.

### *SNARF* Thundercats example
More examples for the people
