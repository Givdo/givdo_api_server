# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cycle_score, :class => 'Cycle::Score' do
    score 0
  end
end
