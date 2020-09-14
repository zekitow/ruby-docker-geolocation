# Ruby Geolocation

Sample app that to perform search a by radius using the elastic search geolocation feature.

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

1. Build the docker containers

```bash
make build
```

2. Run all containers
```bash
make test.up
```

3. Using another terminal session, access bash of the ruby machine and prepare the database and elasticsearch.
```bash
make ruby.bash
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake index:rebuild
```

4. Run the tests
```bash
make test.run
```

Then you should see the output similar to this:

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
make db.bash
psql -Uruby_geolocation -d ruby_geolocation_test
```

Access of IRB console:
```
make ruby.bash
bundle exec irb -r ./app.rb
```

Stop all containers:
```
make down
```