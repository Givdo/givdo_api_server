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

    factory :user_with_finished_player do
      ignore do
        player_score 1
      end

      after(:build) do |user, evalutor|
        user.players << build(:finished_player, score: evalutor.player_score)
      end
    end
  end
end
