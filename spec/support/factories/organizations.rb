FactoryGirl.define do
  factory :organization do
    factory :organization_with_score do
      ignore do
        score 5
      end

      after(:create) do |organization, evalutor|
        organization.players << FactoryGirl.create(:finished_player, score: evalutor.score)
      end
    end
  end
end
