# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    user { create(:user) }
    option { create(:trivia_option) }
    game { create(:game) }
  end
end
