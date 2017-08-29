class User < ApplicationRecord
  PROVIDERS_UID_COLUMN_NAME = {
    facebook: 'facebook_id',
    google_oauth2: 'google_id',
    vkontakte: 'vk_id',
    github: 'gh_id'
  }.freeze

  after_create :create_profile
  has_many :users_to_invite, class_name: 'Invitation', foreign_key: "invitor_id"
  has_many :invitors, class_name: 'Invitation', foreign_key: "user_to_invite_id"
  has_many :user_boards, dependent: :destroy
  has_many :boards, through: :user_boards, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :invited_user_permissions, dependent: :destroy
  has_one  :profile, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2 github vkontakte]

  enum role: [:admin, :user, :guest]

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
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  def create_profile
    Profile.create(id: id, user_id: id)
  end
end
