require 'rails_helper'

feature 'Edit profile spec', '
  I want be able to sign in
  And to see show page of profile
' do
  given(:user) { create(:user) }
  given(:profile) { create(:profile) }

  scenario 'Sign in user go to profile show page' do
    sign_in(user)

    visit profile_path(profile)
    expect(page).to have_content 'Edit Profile'
  end
end
