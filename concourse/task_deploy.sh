#!/bin/bash 
set -e

# TODO: check for required env variables (CF_SPACE)

DEPLOY_GUID=$(ruby -r securerandom -e 'print SecureRandom.hex') # Concourse doesn't give us a build guid :(
APP_NAME=deals_$DEPLOY_GUID
CF_ARGS=$CF_SPACE,$APP_NAME

# TODO: don't re-install cf if it's already available in $PATH
wget "https://cli.run.pivotal.io/stable?release=debian64&source=github" -O /tmp/cf-cli.deb
dpkg -i /tmp/cf-cli.deb

bundle install --path=vendor/bundle --without production 

bundle exec rake cf:cups[$CF_ARGS] cf:deploy[$CF_ARGS]
