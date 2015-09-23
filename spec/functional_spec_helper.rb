require 'spec_helper'
require 'rake'
require 'net/http'

load File.expand_path("Rakefile")

APP_NAME = ENV["APP_NAME"] || "pretend-deals-service-#{SecureRandom.hex(4)}"

raise "You need to have the PRICING_SERVICE_URL environment variable set to run these tests" unless ENV["PRICING_SERVICE_URL"]

RSpec.configure do |rspec|
  rspec.before(:suite) do
    Rake::Task["app:deploy"].invoke(ENV['RACK_ENV'], APP_NAME, APP_NAME, ENV['PRICING_SERVICE_URL'])
  end

  rspec.after(:suite) do
    Rake::Task["app:delete"].invoke(ENV['RACK_ENV'], APP_NAME)
  end
end
