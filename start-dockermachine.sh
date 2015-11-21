#!/bin/bash
# Start docker machine VM named 'default'

docker-machine create --driver virtualbox default
docker-machine start default
eval "$(docker-machine env default)"