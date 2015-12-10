FactoryGirl.define do
  factory :user do
    provider 'facebook'
    sequence(:uid) {|n| n.to_s * 5 }
    sequence(:email) {|n| "user#{n}@givdo-user.com"}
  end
end
