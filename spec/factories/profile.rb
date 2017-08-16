FactoryGirl.define do
  # factory :profile do
  #   first_name 'Mister'
  #   last_name 'Bin'
  #   birthdate Date.today
  #   sex 'Any text'
  #   phone '+37529 1234567'
  #   photo_url 'http://vk.com/photo1'
  # end

  sequence :first_name do |n|
    "Dmitry#{n}"
  end

  sequence :last_name do |n|
    "Batracov#{n}"
  end

  factory :profile do
    user
    first_name
    last_name
    birthdate Date.today
    phone '1234567'
    sex 'male'
  end

  factory :invalid_profile, class: Profile do
    first_name ''
    last_name ''
    birthdate
    phone ''
    sex
    user
  end
end
