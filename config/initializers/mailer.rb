ActionMailer::Base.template_root = RAILS_ROOT + '/app/views/mailers'
ActionMailer::Base.default_url_options[:host] = APP_CONFIG['host']