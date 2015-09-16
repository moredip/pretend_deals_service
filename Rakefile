require 'rake'

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
