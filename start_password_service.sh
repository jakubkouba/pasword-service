#!/usr/bin/env bash

# load gem dependencies
bundle

# build react app
cd app/client
npm run build

# start sinatra
cd ../../
rackup -p 4567
