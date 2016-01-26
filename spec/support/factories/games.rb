# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    association :creator, :factory => :user

    trait :two_players do
      players do
        [build(:player, :user => build(:user))]
      end
    end

    trait :finished do
      after :create do |game|
        trivias = build_list(:trivia, game.rounds, :with_options)
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
