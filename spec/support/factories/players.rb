# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    user { build(:user) }
    game { build(:game) }
  end
end
