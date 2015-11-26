#!/bin/bash 
set -e

DEPLOY_SPACE=$1
DEPLOY_GUID=$(ruby -r securerandom -e 'print SecureRandom.hex') # Concourse doesn't give us a build guid :(
APP_NAME=deals_$DEPLOY_GUID

bundle install --path=vendor/bundle --without production 

bundle exec rake cf:cups[$DEPLOY_SPACE,$APP_NAME] cf:deploy[$DEPLOY_SPACE,$APP_NAME]
