FactoryGirl.define do
  sequence(:token) { |n| "token##{n}" }

  factory :device do
    token
  end
end
