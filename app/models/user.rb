# frozen_string_literal: true

class User < ApplicationRecord
  PROVIDERS_UID_COLUMN_NAME = {:facebook=>'facebook_id', :google_oauth2=>'google_id', :vkontakte=>'vk_id', :github=>'gh_id'}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(email: data['email']).first
  #
  #   # Uncomment the section below if you want users to be created if they don't exist
  #   unless user
  #     user = User.create(email: data['email'], password: Devise.friendly_token[0,20])
  #   end
  #   user
  # end
# =======
  def self.get_uid provider
    PROVIDERS_UID_COLUMN_NAME[provider]
  end

  def self.from_omniauth(auth)
    provider_uid = get_uid(auth.provider.to_sym)
    where(provider: auth.provider, provider_uid=>auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      #    user.name = auth.info.name   # assuming the user model has a name
      #    user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      #     # uncomment the line below to skip the confirmation emails.
      #         # user.skip_confirmation!
    end
  end
end
