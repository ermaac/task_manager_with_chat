require 'rails_helper'

feature 'Edit profile spec', '
  I want be able to sign in
  And to edit My profile page
' do

  given(:user) { create(:user) }
  given(:profile) { create(:profile) }

  scenario 'Sign in user go to edit profile' do
    sign_in(user)

    visit edit_profile_path(profile)

    expect(page).to have_content 'Back'
  end
end
