Devise.setup do |config|
  config.secret_key = '5d0255f72a4fb6f9b23fe720ccc8044f13c7710916e34de8c0b2252477f11ee796632d359bcf20163dcb621d972bfe4029e16522a551eed10a2740d4b76dbef1'

  config.mailer_sender = 'administrador@compartiendoespacios.com'

  require 'devise/orm/active_record'

  config.request_keys = { subdomain: false }

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.omniauth :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
  config.omniauth :facebook, ENV["FACEBOOK_CONSUMER_KEY"], ENV["FACEBOOK_CONSUMER_SECRET"]


  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 5..72

  config.reset_password_within = 6.hours

  config.sign_out_via = :get

end
