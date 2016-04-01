FactoryGirl.define do
  factory :cycle do
    trait :current do
      ended_at nil
    end

    trait :with_score do
      ignore do
        scores 3
        cycle_score 10
      end

      after(:create) do |cycle, evalutor|
        (evalutor.scores).times do
          cycle.scores << FactoryGirl.create(:cycle_score, score: evalutor.cycle_score)
        end
      end
    end
  end
end
