# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    player { create(:player) }
    trivia_option { create(:trivia_option) }
    game { create(:game) }
  end
end
