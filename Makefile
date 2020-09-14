#!/bin/bash

ruby_container = ruby-docker-geolocation_ruby_1
db_container = ruby-docker-geolocation_db_1

clean:
	sudo rm -rf psql/data/
	sudo rm -rf ruby/bundle_cache/*
	sudo rm -rf elasticsearch/data/nodes/
	mkdir -p psql/data/

build:
	docker-compose build

up:
	export RACK_ENV=development && docker-compose up

down:
	docker-compose down

ruby.bash:
	docker exec -ti $(ruby_container) bash

db.bash:
	docker exec -ti $(db_container) bash

test.up:
	export RACK_ENV=test && docker-compose up

test.run:
	export RACK_ENV=test && docker exec -ti $(ruby_container) rspec
