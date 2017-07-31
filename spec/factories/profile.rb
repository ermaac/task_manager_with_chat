FactoryGirl.define do
  factory :profile do
    first_name 'Mister'
    last_name 'Bin'
    birthdate Date.today
    sex 'Any text'
    phone '+37529 1234567'
    photo_url 'http://vk.com/photo1'
  end
end
