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
  task :deploy, [:space, :app_name, :host, :pricing_service_url] do |t, args|
    space = args[:space]
    app_name = args[:app_name]
    host = args[:host]
    pricing_service_url = args[:pricing_service_url]

    puts "deploying..."
    begin
      puts `cf login -a api.run.pivotal.io -u #{ENV['CF_USERNAME']} -p #{ENV['CF_PASSWORD']} -o TW-org -s #{space}`
      puts `cf push #{app_name} -n #{host} --no-start`
      puts `cf set-env #{app_name} PRICING_SERVICE_BASE_URL #{pricing_service_url} > /dev/null 2>&1`
      puts `cf push #{app_name} -n #{host}`
    ensure
      puts `cf logout`
    end
    puts "deployed"
  end

  desc "delete app from cloud foundry"
  task :delete, [:space, :app_name] do |t, args|
    space = args[:space]
    app_name = args[:app_name]

    puts "deleting..."
    begin
      puts `cf login -a api.run.pivotal.io -u #{ENV['CF_USERNAME']} -p #{ENV['CF_PASSWORD']} -o TW-org -s #{space}`
      puts `cf delete -f #{app_name}`
    ensure
      puts `cf logout`
    end
    puts "deleted"
  end
end

task default: ['spec:unit']

