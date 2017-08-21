FactoryGirl.define do
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
