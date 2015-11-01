FactoryGirl.define do
  factory :trivia_option do
    sequence(:text) {|n| "Answer #{n}"}
  end
end
