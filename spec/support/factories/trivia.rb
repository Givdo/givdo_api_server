FactoryGirl.define do
  factory :trivia, :class => 'Trivia' do
    sequence(:question) {|n| "Question #{n}"}
  end
end
