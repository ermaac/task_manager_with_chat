# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.secret_key = '5d4440a9907dc813b56f07fa7f7c95d0e980f6500589d088c39de2f65b96e3b860d1d4b7b5d468590331aa935c5c243dbd5b6759e552f9b652ee877180285c34'

  config.omniauth :google_oauth2,
                  Rails.application.secrets.google_app_id,
                  Rails.application.secrets.google_app_secret,
                  verify_iss: false

  config.omniauth :facebook,
                  Rails.application.secrets.facebook_app_id,
                  Rails.application.secrets.facebook_app_secret,
                  callback_url: 'http://localhost:5000/users/auth/facebook/callback'

  config.omniauth :github,
                  Rails.application.secrets.github_app_id,
                  Rails.application.secrets.github_app_secret,
                  callback_url: 'http://localhost:5000/users/auth/github/callback'

  config.omniauth :vkontakte,
                  Rails.application.secrets.vkontakte_app_id,
                  Rails.application.secrets.vkontakte_app_secret,
                  callback_url: 'http://localhost:5000/users/auth/vkontakte/callback',
                  scope: 'email,offline'
end
