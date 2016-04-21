# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    user { build(:user) }
    game { build(:game) }

    factory :finished_player do
      finished_at Time.current
    end

    factory :unfinished_player do
      finished_at nil
    end
  end
end
