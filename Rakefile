require 'rake'

namespace :spec do
  begin
    require 'rspec/core'
    require 'rspec/core/rake_task'
    require 'ci/reporter/rake/rspec'

    RSpec::Core::RakeTask.new(:unit) do |spec|
      spec.pattern = FileList['spec/unit/*_spec.rb']
    end
    task :unit => 'ci:setup:rspec'

    RSpec::Core::RakeTask.new(:functional) do |spec|
      spec.pattern = FileList['spec/functional/*_spec.rb']
    end
    task :functional => 'ci:setup:rspec'

  rescue LoadError
  end
end

desc "run local server"
task :server do
  exec "foreman start"
end

namespace :app do
  desc "push to cloud foundry"
  task :deploy, [:space, :app_name, :host] do |t, args|
    puts "deploying..."
    `cf login -a api.run.pivotal.io -u #{ENV['CF_EMAIL']} -p #{ENV['CF_PASSWORD']} -o TW-org -s #{args[:space]}`
    app_name = args[:app_name]
    pricing_service_url = "http://pretend-pricing-service-test.cfapps.io/"
    `cf push #{app_name} -n #{args[:host]} --no-start`
    `cf set-env #{app_name} PRICING_SERVICE_BASE_URL #{pricing_service_url} > /dev/null 2>&1`
    `cf push #{app_name} -n #{args[:host]}`
    puts "deployed"
  end

  desc "delete app from cloud foundry"
  task :delete, [:space, :app_name] do |t, args|
    puts "deleting..."
    `cf login -a api.run.pivotal.io -u #{ENV['CF_EMAIL']} -p #{ENV['CF_PASSWORD']} -o TW-org -s #{args[:space]}`
    `cf delete -f #{args[:app_name]}`
    puts "deleted"
  end
end

task default: ['spec:unit']

