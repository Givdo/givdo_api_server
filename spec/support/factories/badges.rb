# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :badge do
    factory :badge_giver, class: 'Badge' do
      name "Giver"
      score 100
    end

    factory :badge_giver_1, class: 'Badge' do
      name "Giver 1"
      score 200
    end
  end
end
