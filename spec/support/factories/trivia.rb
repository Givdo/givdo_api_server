FactoryGirl.define do
  factory :trivia, :class => 'Trivia' do
    sequence(:question) {|n| "Question #{n}"}

    trait :with_options do
      options { build_list :trivia_option, 3 }
    end
  end
end
