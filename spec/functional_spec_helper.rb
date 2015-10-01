require 'spec_helper'
require 'rake'
require 'net/http'

load File.expand_path("Rakefile")

APP_NAME = ENV["APP_NAME"] || SecureRandom.hex(4)
MANAGE_DEPLOYED_APP = ENV["BASE_URL"]
BASE_URL = ENV["BASE_URL"] || "http://#{APP_NAME}_deals.cfapps.io"

raise "You need to have the PRICING_SERVICE_URL or the BASE_URL environment variable set to run these tests" unless ENV["PRICING_SERVICE_URL"] || ENV["BASE_URL"]

RSpec.configure do |rspec|
  rspec.before(:suite) do
    Rake::Task["app:deploy"].invoke(ENV['RACK_ENV'], APP_NAME) unless MANAGE_DEPLOYED_APP
  end

  rspec.after(:suite) do
    Rake::Task["app:delete"].invoke(ENV['RACK_ENV'], APP_NAME) unless MANAGE_DEPLOYED_APP
  end
end
