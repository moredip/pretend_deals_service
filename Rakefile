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
  task :deploy, [:space, :prefix] do |t, args|
    space = args[:space]
    prefix = args[:prefix]
    app_name = "#{prefix}_deals"
    pricing_service = "#{prefix}_pricing_service"

    puts "deploying..."
    begin
      puts `cf login -a api.run.pivotal.io -u #{ENV['CF_USERNAME']} -p #{ENV['CF_PASSWORD']} -o TW-org -s #{space}`
      puts `cf push #{app_name} -n #{app_name} --no-start`
      puts `cf bind-service #{app_name} #{pricing_service}`
      puts `cf push #{app_name} -n #{app_name}`
      puts `cf cups #{app_name}_service -p '{"type":"deals", "url":"http://#{app_name}.cfapps.io"}'`
    ensure
      puts `cf logout`
    end
    puts "deployed"
  end

  desc "delete app from cloud foundry"
  task :delete, [:space, :prefix] do |t, args|
    space = args[:space]
    prefix = args[:prefix]
    app_name = "#{prefix}_deals"
    pricing_service = "#{prefix}_pricing_service"

    puts "deleting..."
    begin
      puts `cf login -a api.run.pivotal.io -u #{ENV['CF_USERNAME']} -p #{ENV['CF_PASSWORD']} -o TW-org -s #{space}`
      puts `cf delete-service -f #{app_name}_service`
      puts `cf unbind-service -f #{app_name} #{pricing_service}`
      puts `cf delete -f #{app_name}`
    ensure
      puts `cf logout`
    end
    puts "deleted"
  end
end

task default: ['spec:unit']

