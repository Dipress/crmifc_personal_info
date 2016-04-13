set :rvm_ruby_string, "2.0.0-p0@crmifc_personal_info"
require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_type, :system
set :rvm_path, "/usr/local/rvm"

set :application, "crmifc_personal_info"
set :repository,  "git@github.com:Dipress/crmifc_personal_info.git"

set :scm, :git
set :user, "root"
set :use_sudo, false

set :branch, "master"
set :deploy_via, :remote_cache
set :keep_releases, 3
set :deploy_to, "/var/www/apps/#{application}"
set :rails_env, "production"
set :domain, "194.54.152.23"
set :scm_command, "/usr/bin/git"
set :scm_verbose, true
set :normalize_asset_timestamps, false

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

role :web, domain
role :app, domain
role :db,  domain, primary: true

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{latest_release} && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "cd #{latest_release} && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
  task :db do
    run "ls -s /var/www/crmifc_personal_info/application.yml #{current_release}/config/application.yml"
    run "ls -s /var/www/crmifc_personal_info/database.yml #{current_release}/config/database.yml"
    run "ls -s /var/www/crmifc_personal_info/mongoid.yml  #{current_release}/config/mongoid.yml"
    run "ls -s /var/www/crmifc_personal_info/secrets.yml #{current_release}/config/secrets.yml"
  end
end

before "deploy:assets:precompile", "deploy:db"
after "deploy", "deploy:cleanup", "deploy:files", "deploy:restart"
