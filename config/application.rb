require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

# module RailsApiBoilerplate
  class Application < Rails::Application
    config.load_defaults 6.0

    config.active_job.queue_adapter = :sidekiq
    config.time_zone = ENV.fetch('TZ', 'Eastern Time (US & Canada)')
    config.active_record.default_timezone = :utc

    # ActionMailer::Base.delivery_method = :smtp
    # ActionMailer::Base.smtp_settings = {
    #   address: 'smtp.sendgrid.net',
    #   port: 25,
    #   domain: "",
    #   authentication: :plain,
    #   user_name: 'apikey',
    #   password: "",
    #   enable_starttls_auto: true
    # }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      user_name:           "icomsec@websight.com.my",
      password:             "Websight@12345",
      authentication:       :plain,
      enable_starttls_auto: true
    }

    config.action_mailer.default_url_options = { host: 'icomsec@websight.com.my' }
    config.action_mailer.default_options = {
      from: "gift@gmail.com",
      reply_to: "gft@gmail.com"
    }

    config.generators do |gen|
      gen.test_framework :rspec
      gen.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
# end
