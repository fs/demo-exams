set :application, "exams"
set :repository,  "git@github.com:fs/rails-exams.git"

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
