#!/bin/bash 
set -e

# TODO: check for required env variables (CF_SPACE)

DEPLOY_UID=$(ruby -r securerandom -e "print SecureRandom.uuid.split('-').first") # Concourse doesn't give us a build guid :(
#DEPLOY_UID=12
APP_NAME=deals$DEPLOY_UID
CF_ARGS=$CF_SPACE,$APP_NAME

# TODO: don't re-install cf if it's already available in $PATH
wget "https://cli.run.pivotal.io/stable?release=debian64&source=github" -O /tmp/cf-cli.deb
dpkg -i /tmp/cf-cli.deb

bundle install --path=vendor/bundle --without production 

bundle exec rake cf:cups[$CF_SPACE,$APP_NAME]
bundle exec rake cf:deploy[$CF_SPACE,$APP_NAME] 
