# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@givdo-user.com"
  end

  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
  end
end
