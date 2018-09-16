# Ruby Geolocation

## Pre-Setup

**Important**

Before clone the project, you should setup your host machine to [encrease virtual memory for ElasticSearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html):

Create the file **/etc/sysctl.d/60-elasticsearch.conf** with the following content:

```
vm.max_map_count=262144
```

This file will prevent you to change the virtual memory size everytime you reboot your machine.
To change the **max_map_count** now, run the command on terminal.

```
sudo sysctl -w vm.max_map_count=262144
```

## Setup

1. Clone this repository
2. Build docker by running **docker-compose build** on terminal
3. Start docker in *test environment* using the command: **export RACK_ENV=test && docker-compose up && docker-compose logs -f**
4. Execute the tests using the command **docker exec -ti rubydockergeolocation_ruby_1 rspec**

To make the setup easier to run:

```sh
# Clone the repository
git clone git@github.com:zekitow/ruby-docker-geolocation.git ruby-docker-geolocation
cd ruby-docker-geolocation

# Build the docker (only needed for the first run)
docker-compose build

# Launch docker in test env
export RACK_ENV=test && docker-compose up && docker-compose logs -f

# On a new tab execute rspec tests
docker exec -ti rubydockergeolocation_ruby_1 rspec
```

If everthing works fine, you should see the output similar to this:

```sh
HomeController
  when I am authorized
    GET /
      when I access the root page
        should eql 401
        should include "401"

Finished in 0.09788 seconds (files took 0.85396 seconds to load)
2 examples, 0 failures
```

The url to access the application via browser is: [http://127.0.0.1:3000](http://127.0.0.1:3000)

## API Specification

## API /properties

This API is responsible to filter persisted properties by some parameters and return all other properties in a 5km radius, along the address and their prices.

| Param            | Description                                         | Required  | Type     |
|------------------|-----------------------------------------------------|-----------|----------|
| lng              | Coordinate for Longitude                            | Yes       | Decimal  |
| lat              | Coordinate for Latitude                             | Yes       | Decimal  |
| property_type    | Type of property (apartment or single_family_house) | Yes       | String   |
| marketing_type   | Type of marketing (sell or rent)                    | Yes       | String   |


### Curl Example

```sh
curl -v http://127.0.0.1:3000/api/properties?lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell
```

Expected return:

```json
[
  {

    "house_number" : "31", 
    "street" : "Marienburger Straße", 
    "city" : "Berlin", 
    "zip_code" : "10405",
    "state" : "Berlin",
    "lat" : "13.4211476",
    "lng" : "52.534993",
    "price" : "350000"

  },
  {

    "house_number" : "16", 
    "street" : "Winsstraße", 
    "city" : "Berlin", 
    "zip_code" : "10405",
    "state" : "Berlin",
    "lat" : "52.533533",
    "lng" : "13.425226",
    "price" : "320400"

  }
]
```

#### Useful notes

Access of PG console:

```
docker exec -ti rubydockergeolocation_db_1 psql -Uruby_geolocation -d ruby_geolocation_test
```

Access of IRB console:

```
cd web
docker exec -ti rubydockergeolocation_ruby_1 bundle exec irb -r ./app.rb 
```
