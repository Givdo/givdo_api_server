# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    player
    trivia
    trivia_option
    game
  end
end
