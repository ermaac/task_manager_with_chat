class User < ApplicationRecord
  has_many :users_to_invite, class_name: 'Inviting', foreign_key: "invitor_id"
  has_many :invitors, class_name: 'Inviting', foreign_key: "user_to_invite_id"

  PROVIDERS_UID_COLUMN_NAME = {:facebook=>'facebook_id', :google_oauth2=>'google_id', :vkontakte=>'vk_id', :github=>'gh_id'}
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
