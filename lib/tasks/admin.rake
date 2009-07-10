namespace :db do
  desc "Populate User, Exam and Questions"
  task :admin => :environment do
    raise 'You can run populator only on development env' unless Rails.env.development?

    require 'populator'
    require 'faker'

    # Create uses
    User.populate(1) do |user|
      user.name = Faker::Name.name
      user.email = 'admin@flatsoft.com'
      user.encrypted_password = "837ed86d106f35c21a03268e2aba36d510bccc6c"
      user.salt = "8cafe097fbd4cd4d056f2464d155d0c6a25b70ff"
      user.token = nil
      user.token_expires_at = nil
      user.email_confirmed = true
      user.admin = true
    end
  end
end