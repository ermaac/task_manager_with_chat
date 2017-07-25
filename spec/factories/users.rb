FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password '123123123'
    password_confirmation '123123123'
  end
end
