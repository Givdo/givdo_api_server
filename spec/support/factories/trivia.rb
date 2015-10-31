# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trivia, :class => 'Trivia' do
    question "MyText"
  end
end
