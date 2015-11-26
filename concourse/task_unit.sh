#!/bin/bash 
bundle install --without production
bundle exec rake spec:unit
