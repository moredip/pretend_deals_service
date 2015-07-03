$LOAD_PATH.unshift File.expand_path( "../lib", __FILE__ )

require 'request_store'

require 'deals_service/api'
require 'microscope/tracer'

if ENV['RACK_ENV'].downcase == 'development'
  $stdout.sync = true
  puts "running in DEV MODE!"
end

use RequestStore::Middleware
use Microscope::Tracer
run DealsService::API
