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
  rescue LoadError
  end
end

desc "run local server"
task :server do
  exec "foreman start"
end

desc "push to cloud foundry dev"
task :deploy_dev do
  sh "cf api api.run.pivotal.io"
  sh "cf login -a api.run.pivotal.io -u #{ENV['CF_EMAIL']} -p #{ENV['CF_PASSWORD']} -o TW-org -s development"
  sh "cf push -n pretend-deals-service-dev"
end

task default: ['spec:unit']
