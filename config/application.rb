require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Seproerails4
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    ENV["TWITTER_CONSUMER_KEY"] = "rwKZJPM87WKHsxxoLoq69DmF3"
    ENV["TWITTER_CONSUMER_SECRET"] = "r64dn1k4qjmUDoNdJfSQEGiBQzfn27YQAe7Yy0sfOLjcGYb4Il"
    ENV["FACEBOOK_CONSUMER_KEY"] = "1402222820032002"
    ENV["FACEBOOK_CONSUMER_SECRET"] = "40fddf40fd76a66021475dd544480226"

  end
end
