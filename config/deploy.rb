# To see all the available tasks run cap -T
# Mostly common used tasks:
# - cap deploy:update
# - cap apache:lock
# - cap apache:unlock

require "rvm/capistrano"

ssh_options[:port] = 2222
ssh_options[:forward_agent] = true
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/servers/leaseweb"]

default_run_options[:pty] = true

set :copy_exclude, [".svn", ".DS_Store", 'cache']
set :keep_releases, 10
set :application, "Meeting-Point"
set :user, 'mencio'
set :repository,  "git@github.com:mensfeld/media-lab-2013-project.git"
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :rake, '/usr/bin/rake'
set :domain, 'senpuu.net'
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/mensfeld/meeting-point.mensfeld.pl"
set :rails_env, "production"
set :use_sudo, false

role :web, domain, :primary => true
role :app, domain, :primary => true
role :db,  domain, :primary => true

namespace :apache do

  desc 'Restarts the current project Passenger'
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc 'Sets Apache server in dev mode - so the 503 page is served'
  task :lock do
    run "touch #{current_path}/tmp/maintenance.txt"
  end

  desc 'Sets Apache to a standard mode and restarts the current Passenger app'
  task :unlock do
    run "rm -f #{current_path}/tmp/maintenance.txt"
  end

end

namespace :application do

  desc 'Removes all unnecessary directories and files'
  task :cleanup do
    ['.rvmrc', 'test', 'doc', 'db/seeds.rb', 'config/deploy.rb'].each do |path|
      run "rm -rf #{current_release}/#{path}"
    end
  end

  desc 'Creates symlinks to shared directories'
  task :symlinks do
    ['public/files', 'public/assets', 'public/images'].each do |path|
      run "rm -rf #{current_release}/#{path}"
      run "ln -s #{shared_path}/#{path} #{current_release}/#{path}"
    end

    run "rm -rf #{current_release}/public/uploads"
    run "ln -s #{shared_path}/public/files #{current_release}/public/uploads"
  end

  desc 'Copies all the settings files that are required to run application'
  task :settings do
    ['config/database.yml', 'config/application.yml'].each do |path|
      run "rm -rf #{current_release}/#{path}"
      run "cp -r #{shared_path}/#{path} #{current_release}/#{path}"
    end
  end

  desc 'Installs all necessary gems and libs'
  task :bundle do
    run "cd #{current_release} && bundle install --path ./.bundle --without test development"
  end

  desc 'Clean all assets under tmp/cache'
  task :assets do
    path = "#{latest_release}/tmp/cache"
    run "rm -rf #{path}"
    run "mkdir #{path}"
    run "chmod -R 777 #{path}"
  end

end

# Before performing update stop Resque server and lock Apache into maintanance
before 'deploy:update' do
  #apache.lock
end

# After we update code, we need to do a code cleanup, create symlinks and
# copy configuration files that are necessary
after 'deploy:update_code' do
  application.cleanup
  application.assets
  application.symlinks
  application.settings
  application.bundle
  #apache.lock
end

# After full update we need to do a cleanup of old realeses, migrate the db,
# start resque queue and unlock apache
after 'deploy:update' do
  apache.lock
  deploy.cleanup
  deploy.migrate
  apache.restart
  apache.unlock
end
