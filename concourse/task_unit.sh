#!/bin/bash 
gem install bundler
bundle install --without production
bundle exec rake spec:unit
