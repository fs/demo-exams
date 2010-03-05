set :application, "exams"
set :repository,  "git@github.com:fs/demo-exams.git"
set :scm, :git

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/rails/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "exams.flatsoft.com"
role :web, "exams.flatsoft.com"
role :db,  "exams.flatsoft.com", :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

  desc "Run this x every successful deployment"
  task :after_default do
    cleanup
  end
end

namespace :db do
  desc "Create database password in shared path"
  task :password do
    set :db_password, Proc.new { Capistrano::CLI.password_prompt("Remote database password: ") }
    run "mkdir -p #{shared_path}/config"
    put db_password, "#{shared_path}/config/dbpassword"
  end
end
