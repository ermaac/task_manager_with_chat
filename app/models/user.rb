# frozen_string_literal: true

class User < ApplicationRecord
  PROVIDERS_UID_COLUMN_NAME = {
    facebook: 'facebook_id',
    google_oauth2: 'google_id',
    vkontakte: 'vk_id',
    github: 'gh_id'
  }.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2 github vkontakte]

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.get_uid(provider)
    PROVIDERS_UID_COLUMN_NAME[provider]
  end

  def self.from_omniauth(auth)
    provider_uid = get_uid(auth.provider.to_sym)
    where(provider: auth.provider, provider_uid => auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
