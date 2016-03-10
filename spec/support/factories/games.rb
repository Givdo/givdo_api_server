# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    creator { build(:user) }
    category { build(:category) }

    trait :two_players do
      players do
        [build(:player)]
      end
    end

    trait :finished do
      after :create do |game|
        trivias = build_list(:trivia, game.rounds, :with_options, category: game.category)
        game.players.each do |player|
          trivias.each do |trivia|
            player.answer!({
              :trivia => trivia,
              :trivia_option => trivia.options.sample
            })
          end
        end
      end
    end
  end
end
