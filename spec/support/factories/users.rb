FactoryGirl.define do
  factory :user do
    provider 'facebook'
    sequence(:uid) {|n| n.to_s * 5 }
    sequence(:email) {|n| "user#{n}@givdo-user.com"}
    organization

    factory :user_with_activities do
      ignore do
        activities_count 5
      end
      after(:create) do |user, evalutor|
        evalutor.activities_count.times { user.activities << create(:activity) }
      end
    end
  end
end
